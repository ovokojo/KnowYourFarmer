import 'dart:io';
import 'dart:convert';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/services/directoryGenerator.dart';

class localStorage {
  Future<String> get _localPath async {
    Future<String> path = DirectoryGenerator.createFolder("farmers");
    return path;
  }

  Future<File> _getFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename.json');
  }

  Future<File> storeFarmerOffline(Farmer farmer) async {
    print("storing farmer...");
    File file = await _getFile(farmer.uid);
    print("storeFarmerOffline: saving file..");
    return file.writeAsString(json.encode(farmer.toJson()));
  }
}
