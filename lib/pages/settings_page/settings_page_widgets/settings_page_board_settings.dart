import 'package:flutter/material.dart';

ListTile getBoardSettingListTile(String title, int value) {
  return ListTile(
    leading: Icon(
      Icons.label,
      color: Colors.brown[800],
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    subtitle: Text(
      value.toString(),
      style: TextStyle(
        color: Colors.grey[300],
      ),
    ),
  );
}

Slider getBoardSettingSlider(
    int value, int min, int max, void Function(double newValue) onChanged) {
  return Slider(
    value: value.toDouble(),
    activeColor: Colors.orange,
    inactiveColor: Colors.grey,
    onChanged: onChanged,
    min: min.toDouble(),
    max: max.toDouble(),
  );
}
