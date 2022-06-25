import 'package:flutter/material.dart';
import 'package:kyf_mobile/styles/colors.dart';

InputDecoration primaryFormDecoration(String label) {
  return InputDecoration(
      filled: true,
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: greenPrimary, width: 1)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: greenPrimary, width: 2)));
}
