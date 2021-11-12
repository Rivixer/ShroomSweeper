import 'package:flutter/material.dart';
import 'package:minesweeper/models/default_levels.dart';
import '../utils/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int columns = Settings.getColumns();
  int rows = Settings.getRows();
  int bombs = Settings.getBombs();

  void _reloadVariables() {
    columns = Settings.getColumns();
    rows = Settings.getRows();
    bombs = Settings.getBombs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Ustawienia"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.label,
                color: Colors.brown[800],
              ),
              title: const Text(
                'Kolumny:',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                columns.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ),
            Slider(
              value: columns.toDouble(),
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              onChanged: (newValue) {
                setState(
                  () {
                    Settings.setColumns(newValue.toInt());
                    columns = Settings.getColumns();
                    bombs = bombs > rows * columns ~/ 3
                        ? rows * columns ~/ 3
                        : bombs;
                    Settings.setBombs(bombs);
                  },
                );
              },
              min: 3,
              max: 12,
            ),
            ListTile(
              leading: Icon(
                Icons.label,
                color: Colors.brown[800],
              ),
              title: const Text(
                'Wiersze:',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                rows.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ),
            Slider(
              value: rows.toDouble(),
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              onChanged: (newValue) {
                setState(() {
                  Settings.setRows(newValue.toInt());
                  rows = Settings.getRows();
                  bombs =
                      bombs > rows * columns ~/ 3 ? rows * columns ~/ 3 : bombs;
                  Settings.setBombs(bombs);
                });
              },
              min: 3,
              max: 50,
            ),
            ListTile(
              leading: Icon(
                Icons.label,
                color: Colors.brown[800],
              ),
              title: const Text(
                'Bomby:',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                bombs.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ),
            Slider(
              value: bombs < rows * columns ~/ 3
                  ? bombs.toDouble()
                  : (rows * columns ~/ 3).toDouble(),
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              onChanged: (newValue) {
                setState(
                  () {
                    Settings.setBombs(newValue.toInt());
                    bombs = Settings.getBombs();
                  },
                );
              },
              min: 3,
              max: (rows * columns ~/ 3).toDouble(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getElevatedButton("ŁATWY"),
                _getElevatedButton("ŚREDNI"),
                _getElevatedButton("TRUDNY"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _getElevatedButton(String level) {
    ButtonStyle buttonStyle;
    if (level == "ŁATWY" && EasyLevel().isThisLevel(columns, rows, bombs) ||
        level == "ŚREDNI" && MediumLevel().isThisLevel(columns, rows, bombs) ||
        level == "TRUDNY" && HardLevel().isThisLevel(columns, rows, bombs)) {
      buttonStyle = ElevatedButton.styleFrom(
        primary: Colors.brown[800],
        onPrimary: Colors.orange,
        alignment: Alignment.center,
      );
    } else {
      buttonStyle = ElevatedButton.styleFrom(
        primary: Colors.orange,
        onPrimary: Colors.brown[800],
        alignment: Alignment.center,
      );
    }
    return ElevatedButton(
      onPressed: () {
        switch (level) {
          case "ŁATWY":
            EasyLevel().setLevel();
            break;
          case "ŚREDNI":
            MediumLevel().setLevel();
            break;
          case "TRUDNY":
            HardLevel().setLevel();
            break;
        }
        _reloadVariables();
        setState(() {});
      },
      child: Text(level),
      style: buttonStyle,
    );
  }
}
