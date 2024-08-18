import 'package:flutter/material.dart';

Future<dynamic> diolagMethod(BuildContext context, {required child}) {
  return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: child,
        );
      });
}
