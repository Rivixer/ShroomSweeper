import 'package:flutter/material.dart';
import 'pages/game_page.dart';
import 'utils/settings.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.init();
  runApp(const Minesweeper());
}

class Minesweeper extends StatelessWidget {
  const Minesweeper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return const MaterialApp(
      home: Game(),
    );
  }
}
