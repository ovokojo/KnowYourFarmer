import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/models/ipfs_response.dart';
import 'package:kyf_mobile/services/constants.dart';
import 'package:kyf_mobile/services/localStorage.dart';
import 'package:path/path.dart';

class IpfsUploader {
  String token = ipfsToken;
  upload({required BuildContext context, required Farmer farmer}) async {
    // Encrypt data
    final jsonString = jsonEncode(farmer.toJson());
    var bytes = utf8.encode(jsonString); // data being hashed
    var digest = sha256.convert(bytes);
    final encryptedData = digest.toString();
    print("encryptedData ${encryptedData.length} chars");
    print(encryptedData);
    // store data offline
    print("storing...");
    final localEncryptedData =
        await LocalStorage().storeEncryptedDataOffline(uid: farmer.uid, data: encryptedData);
    final localFarmerData = await LocalStorage().storeFarmerOffline(farmer);
    print("farmerData:");
    print(localFarmerData.runtimeType);
    // TODO: Send data to server

    // Upload to ipfs
    _uploadToIpfs(context, localEncryptedData);
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
        print(response.data.runtimeType);
        final body = Map<String, dynamic>.from(response.data);
        final result = Map<String, dynamic>.from(body["value"]);
        final ipfsResponse = ipfsResponseFromJson(result);
        print(ipfsResponse.toString());
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
