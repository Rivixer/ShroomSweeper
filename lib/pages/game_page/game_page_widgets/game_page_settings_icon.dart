import 'package:flutter/material.dart';

Row getSettingsIconWidget(BuildContext context, void Function() onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Spacer(),
      Center(
        child: IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            Icons.settings,
            size: 28,
          ),
          onPressed: onPressed,
        ),
      ),
    ],
  );
}
