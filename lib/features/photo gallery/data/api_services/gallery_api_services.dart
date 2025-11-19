import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class GalleryApiServices {
  GalleryApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> getGallery({
    int perPage = 15,
    int page = 1,
  }) {
    return _dioHelper.get(
      endPoint: EndPoints.getGallery,
      data: {
        'per_page': perPage,
        'page': page,
      },
    );
  }

  Future<Response?> addGalleryItem({
    required File imageFile,
    required String comment,
  }) async {
    final Map<String, dynamic> payload = {
      'comment': comment,
    };

    payload['image'] = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
      contentType: _mapContentType(imageFile),
    );

    final formData = FormData.fromMap(payload);

    return _dioHelper.post(
      endPoint: EndPoints.getGallery,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  MediaType? _mapContentType(File file) {
    final path = file.path.toLowerCase();
    if (path.endsWith('.png')) return MediaType('image', 'png');
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) {
      return MediaType('image', 'jpeg');
    }
    if (path.endsWith('.gif')) return MediaType('image', 'gif');
    if (path.endsWith('.webp')) return MediaType('image', 'webp');
    return MediaType('application', 'octet-stream');
  }
}

