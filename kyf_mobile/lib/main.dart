import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kyf_mobile/screens/new_farmer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Your Farmer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NewFarmer(),
    );
  }
}
