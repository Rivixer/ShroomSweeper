import 'package:flutter/material.dart';
import 'package:minesweeper/utils/settings.dart';

SwitchListTile getUseVibrationSwitch(Function setState) {
  return SwitchListTile(
    title: const Text(
      "Wibracje: ",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    activeColor: Colors.orange,
    value: Settings.getVibration(),
    onChanged: (bool newValue) {
      Settings.setVibration(newValue);
      setState(() {});
    },
  );
}
