import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/photo gallery/data/models/gallery_response.dart';
import 'package:non_stop/features/photo gallery/data/repos/gallery_repository.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit({GalleryRepository? galleryRepository})
      : _galleryRepository = galleryRepository ?? getIt<GalleryRepository>(),
        super(GalleryInitial());

  final GalleryRepository _galleryRepository;

  File? selectedFile;
  List<GalleryItemModel> galleryItems = [];
  PaginationModel? pagination;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMorePages = true;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      selectedFile = File(result.files.single.path!);

      emit(PickImageSuccessState());
    } else {
      emit(PickImageErrorState());
    }
  }

  Future<void> getAllGalleries({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMorePages) return;
      isLoadingMore = true;
      emit(GalleryLoadMoreLoading());
      currentPage++;
    } else {
      currentPage = 1;
      galleryItems = [];
      hasMorePages = true;
      emit(GalleryLoading());
    }

    final api_result.ApiResult<GalleryData> result =
        await _galleryRepository.getGallery(
      perPage: 10,
      page: currentPage,
    );

    if (result is api_result.Success<GalleryData>) {
      final data = result.data;
      pagination = data.pagination;
      
      if (loadMore) {
        galleryItems.addAll(data.items ?? []);
        isLoadingMore = false;
        hasMorePages = (pagination?.currentPage ?? 0) < (pagination?.lastPage ?? 0);
        emit(GalleryLoadMoreSuccess(galleryItems, pagination!));
      } else {
        galleryItems = data.items ?? [];
        hasMorePages = (pagination?.currentPage ?? 0) < (pagination?.lastPage ?? 0);
        emit(GallerySuccess(galleryItems, pagination!));
      }
      return;
    }

    if (result is api_result.Failure<GalleryData>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      if (loadMore) {
        isLoadingMore = false;
        currentPage--; // Revert page increment
        emit(GalleryLoadMoreFailure(message));
      } else {
        emit(GalleryFailure(message));
      }
      return;
    }

    if (loadMore) {
      isLoadingMore = false;
      currentPage--; // Revert page increment
      emit(GalleryLoadMoreFailure('unexpectedErrorOccurred'.tr()));
    } else {
      emit(GalleryFailure('unexpectedErrorOccurred'.tr()));
    }
  }

  Future<void> addGalleryItem(String comment) async {
    if (selectedFile == null) {
      emit(GalleryUploadFailure('pleaseSelectImage'.tr()));
      return;
    }

    if (comment.trim().isEmpty) {
      emit(GalleryUploadFailure('pleaseEnterComment'.tr()));
      return;
    }

    emit(GalleryUploadLoading());

    final api_result.ApiResult<Map<String, dynamic>> result =
        await _galleryRepository.addGalleryItem(
      imageFile: selectedFile!,
      comment: comment.trim(),
    );

    if (result is api_result.Success<Map<String, dynamic>>) {
      final message = result.data['message'] as String? ?? 'galleryItemAddedSuccessfully'.tr();
      selectedFile = null; // Clear selected file after successful upload
      emit(GalleryUploadSuccess(message));
      // Refresh gallery list
      await getAllGalleries();
      return;
    }

    if (result is api_result.Failure<Map<String, dynamic>>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(GalleryUploadFailure(message));
      return;
    }

    emit(GalleryUploadFailure('unexpectedErrorOccurred'.tr()));
  }
}
