import 'package:flutter/material.dart';
import 'game.dart';
import 'utils/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.init();
  runApp(const Minesweeper());
}

class Minesweeper extends StatelessWidget {
  const Minesweeper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Game(),
    );
  }
}
