import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class DirectoryGenerator {
  static Future<Directory> _getAppDirectory() async {
    final Directory _appDirectory = await getApplicationSupportDirectory();
    return _appDirectory;
  }

  static Future<String> createFolder(String folderName) async {
    // Get this App Document Directory
    final Directory _appDirectory = await _getAppDirectory(); // change for iOS
    // App Document Directory + folder name
    final Directory _appDirectoryFolder = Directory('${_appDirectory.path}/$folderName/');

    if (await _appDirectoryFolder.exists()) {
      // if folder already exists return path
      return _appDirectoryFolder.path;
    } else {
      // if folder not exists create folder and then return its path
      final Directory _appDirectoryNewFolder = await _appDirectoryFolder.create(recursive: true);
      return _appDirectoryNewFolder.path;
    }
  }

  Future<File> pngImageToFile(Uint8List image, String name) async {
    String path = await createFolder('images');
    File file = await File('$path$name.png').create();
    file.writeAsBytesSync(image);
    return file;
  }
}
