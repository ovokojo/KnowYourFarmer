import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/services/localStorage.dart';

class ipfsUploader {
  upload({required BuildContext context, required Farmer farmer}) async {
    // store data offline
    print("upload...");
    final farmerData = await localStorage().storeFarmerOffline(farmer);
    print("farmerData:");
    print(farmerData.runtimeType);
    // Upload to ipfs
  }

  _uploadToIpfs(BuildContext context, File data) async {
    print("_uploadToIpfs...");
  }
}
