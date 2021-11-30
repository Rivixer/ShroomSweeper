import 'package:flutter/material.dart';

class Alerts {
  static Future<bool?> showResetWhenSettingsAreChanged(
      BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Zmiana wartości spowoduje reset obecnej gry!\nChcesz tego?',
          style: TextStyle(fontSize: 14.5),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Nie')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Tak')),
        ],
      ),
    );
  }
}
