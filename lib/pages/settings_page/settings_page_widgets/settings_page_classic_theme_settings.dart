import 'package:flutter/material.dart';
import 'package:minesweeper/utils/settings.dart';

SwitchListTile getUseClassicThemeSwitch(Function setState) {
  return SwitchListTile(
    title: const Text(
      "Motyw klasyczny: ",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    activeColor: Colors.orange,
    value: Settings.getUseNumbers(),
    onChanged: (bool newValue) {
      Settings.setUseNumbers(newValue);
      setState(() {});
    },
  );
}
