import 'package:flutter/material.dart';

class AppBottomSheet {
  static showBottomSheet(
    BuildContext context, {
    required Widget child,
     bool isDismissible = true,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Wrap(
            children: [child],
          ),
        );
      },
    );
  }
}
