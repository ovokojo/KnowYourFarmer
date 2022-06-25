import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/services/constants.dart';
import 'package:kyf_mobile/services/localStorage.dart';
import 'package:path/path.dart';

class ipfsUploader {
  String token = ipfsToken;
  upload({required BuildContext context, required Farmer farmer}) async {
    // store data offline
    print("upload...");
    final farmerData = await localStorage().storeFarmerOffline(farmer);
    print("farmerData:");
    print(farmerData.runtimeType);
    // Upload to ipfs
    _uploadToIpfs(context, farmerData);
  }

  _uploadToIpfs(BuildContext context, File data) async {
    print("_uploadToIpfs..");
    dio.Dio dioApi = new dio.Dio();
    try {
      dioApi.options.headers['accept'] = 'application/json';
      dioApi.options.headers['Content-Type'] = 'multipart/form-data';
      dioApi.options.headers['Authorization'] = 'Bearer $token';
      String fileName = basename(data.path);
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(data.path, filename: fileName),
      });
      final response = await dioApi.post('https://api.nft.storage/upload', data: formData);
      if (response.statusCode == 200) {
        print("success!");
        print(response.data);
      } else {
        print("error");
        print(response.statusCode);
        print(response.data);
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
