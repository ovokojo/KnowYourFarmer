import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/services/constants.dart';
import 'package:kyf_mobile/services/localStorage.dart';
import 'package:http/http.dart' as http;

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
    // function to upload to ipfs
    print("_uploadToIpfs..");
    final Uri ipfsUrl = Uri.parse("https://api.nft.storage/upload");
    try {
      var request = http.MultipartRequest('POST', ipfsUrl)
        ..headers.addAll({
          'accept': 'application/json',
          // 'Content-Type': 'multipart/form-data',
          'Content-Type': 'application/octet-stream',
          'Authorization': 'Bearer $token'
        })
        ..files.add(await http.MultipartFile.fromPath('farmers', data.path));
      //.add(http.MultipartFile.fromBytes('file', await File.fromUri(data.uri).readAsBytes()));
      // Sending post request...
      print("Sending post request..");
      final response = await request.send();
      if (response.statusCode == 200) {
        print("Success!!");
        print(response.stream.transform(Utf8Decoder()).listen((value) {
          print("Response:");
          print(value);
          print(value.runtimeType);
        }));
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err.toString());
    }
    print("_uploadToIpfs...");
  }
}
