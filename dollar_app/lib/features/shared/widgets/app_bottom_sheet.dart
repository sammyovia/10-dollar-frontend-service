import 'package:flutter/material.dart';



class AppBottomSheet {
  static showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      isDismissible: false,
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [child],
        );
      },
    );
  }
}
