import 'package:flutter/material.dart';

void handleGameOver(BuildContext context, Function initialiseGame) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Przegrywasz!"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                initialiseGame();
                Navigator.pop(context);
              },
              child: const Text("Spróbuj ponownie!")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ukryj!"))
        ],
      );
    },
  );
}

void handleWin(BuildContext context, Function initialiseGame) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Wygrywasz!"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                initialiseGame();
                Navigator.pop(context);
              },
              child: const Text("Jeszcze raz!")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ukryj!"))
        ],
      );
    },
  );
}
