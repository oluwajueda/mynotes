import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/colors.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog(
    {required BuildContext context, required String text}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(buttonColor),
        ),
        const SizedBox(height: 10.0),
        Text(text),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: ((context) => dialog),
  );

  return () => Navigator.of(context).pop();
}
