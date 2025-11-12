import 'package:dio/dio.dart';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class ProfileApiServices {
  ProfileApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> fetchProfile() {
    return _dioHelper.get(
      endPoint: EndPoints.getProfileData,
    );
  }

  Future<Response?> updateProfile({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? phone,
    String? gender,
    File? imageFile,
  }) async {
    final Map<String, dynamic> payload = {};

    void addIfNotEmpty(String key, String? value) {
      if (value != null && value.trim().isNotEmpty) {
        payload[key] = value.trim();
      }
    }

    addIfNotEmpty('name', name);
    addIfNotEmpty('email', email);
    addIfNotEmpty('password', password);
    addIfNotEmpty('password_confirmation', passwordConfirmation);
    addIfNotEmpty('phone', phone);
    addIfNotEmpty('gender', gender);

    if (imageFile != null) {
      payload['image'] = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        contentType: _mapContentType(imageFile),
      );
    }

    final formData = FormData.fromMap(payload);

    return _dioHelper.post(
      endPoint: EndPoints.getProfileData,
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

