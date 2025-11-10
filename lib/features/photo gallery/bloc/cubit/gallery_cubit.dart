import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/features/photo%20gallery/bloc/cubit/gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  File? selectedFile;

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
}
