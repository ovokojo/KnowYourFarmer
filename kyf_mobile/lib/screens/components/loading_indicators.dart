import 'package:flutter/material.dart';

Widget loadingIndicatorWithLabel({required BuildContext context, required String label}) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
        ),
        Text(label)
      ],
    ),
  );
}

Widget smallLoadingIndicator() {
  return Container(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(
      color: Colors.green,
      strokeWidth: 2,
    ),
  );
}
