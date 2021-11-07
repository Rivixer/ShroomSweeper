import 'package:flutter/material.dart';
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
              leading: const Icon(Icons.label),
              title: const Text('Kolumny:'),
              subtitle: Text(columns.toString()),
            ),
            Slider(
              value: columns.toDouble(),
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
              leading: const Icon(Icons.label),
              title: const Text('Wiersze:'),
              subtitle: Text(rows.toString()),
            ),
            Slider(
              value: rows.toDouble(),
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
              leading: const Icon(Icons.label),
              title: const Text('Bomby:'),
              subtitle: Text(bombs.toString()),
            ),
            Slider(
              value: bombs < rows * columns ~/ 3
                  ? bombs.toDouble()
                  : (rows * columns ~/ 3).toDouble(),
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
          ],
        ),
      ),
    );
  }
}
