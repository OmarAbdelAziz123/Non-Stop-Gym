part of 'gallery_cubit.dart';

sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

final class PickImageSuccessState extends GalleryState {}

final class PickImageErrorState extends GalleryState {}

final class GalleryLoading extends GalleryState {}

final class GallerySuccess extends GalleryState {
  GallerySuccess(this.items, this.pagination);

  final List<GalleryItemModel> items;
  final PaginationModel pagination;
}

final class GalleryUsersUpdated extends GalleryState {}

final class GalleryFailure extends GalleryState {
  GalleryFailure(this.message);

  final String message;
}

final class GalleryLoadMoreLoading extends GalleryState {}

final class GalleryLoadMoreSuccess extends GalleryState {
  GalleryLoadMoreSuccess(this.items, this.pagination);

  final List<GalleryItemModel> items;
  final PaginationModel pagination;
}

final class GalleryLoadMoreFailure extends GalleryState {
  GalleryLoadMoreFailure(this.message);

  final String message;
}

final class GalleryUploadLoading extends GalleryState {}

final class GalleryUploadSuccess extends GalleryState {
  GalleryUploadSuccess(this.message);

  final String message;
}

final class GalleryUploadFailure extends GalleryState {
  GalleryUploadFailure(this.message);

  final String message;
}
