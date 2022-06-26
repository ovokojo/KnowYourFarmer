import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kyf_mobile/services/constants.dart';
import 'package:http/http.dart' as http;

uploadToServer(
    {required BuildContext context, required String ipfsCid, required String data}) async {
  String _token = bubbleToken;
  print("_uploadToIpfs..");
  try {
    final Uri serverUrl =
        Uri.parse("https://knowyourfarmer.bubbleapps.io/version-test/api/1.1/obj/farmer");
    final http.Response response = await http.post(
      serverUrl,
      body: {"cid": ipfsCid, "identity": data},
      headers: {'accept': '*/*', 'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 200) {
      print("success!");
      print(response.body);
      print(response.body.runtimeType);
      final body = Map<String, dynamic>.from(jsonDecode(response.body));
      print(body.toString());
    } else {
      print("error");
      print(response.statusCode);
      print(response.body);
    }
  } catch (err) {
    print(err.toString());
  }
}
