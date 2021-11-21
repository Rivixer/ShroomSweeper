import 'package:flutter/material.dart';
import 'package:minesweeper/models/default_levels.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../utils/settings.dart';

class SettingsPage extends StatefulWidget {
  final bool? inGame;
  const SettingsPage({Key? key, this.inGame}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool boardChanged = false;
  int columns = Settings.getColumns();
  int rows = Settings.getRows();
  int bombs = Settings.getBombs();
  bool useNumbers = Settings.getUseNumbers();
  late bool? inGame = widget.inGame;

  void _reloadVariables() {
    columns = Settings.getColumns();
    rows = Settings.getRows();
    bombs = Settings.getBombs();
    useNumbers = Settings.getUseNumbers();
  }

  Future<String> _getVersionApp() async {
    try {
      var packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      return 'debug';
    }
  }

  Future<bool?> showAlert(BuildContext context) async {
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

  Future<bool> _canChangeValues() async {
    if (inGame != true || (await showAlert(context) ?? false)) {
      inGame = null;
      boardChanged = true;
      return true;
    }
    return false;
  }

  List<Widget> getBoardSetting(
      String title, int value, int min, int max, Function setValue) {
    return [
      ListTile(
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
      ),
      Slider(
        value: value.toDouble(),
        activeColor: Colors.orange,
        inactiveColor: Colors.grey,
        onChanged: (newValue) async {
          if (await _canChangeValues()) {
            setState(
              () {
                setValue(newValue.toInt());
                _reloadVariables();
                if (bombs > rows * columns ~/ 3) {
                  Settings.setBombs(rows * columns ~/ 3);
                  _reloadVariables();
                }
              },
            );
          }
        },
        min: min.toDouble(),
        max: max.toDouble(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, boardChanged);
        return Future.value(boardChanged);
      },
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Ustawienia"),
          leading:
              BackButton(onPressed: () => Navigator.pop(context, boardChanged)),
        ),
        body: Center(
          child: Column(
            children: getBoardSetting(
                    'Kolumny:', columns, 3, 12, Settings.setColumns) +
                getBoardSetting('Wiersze:', rows, 3, 50, Settings.setRows) +
                getBoardSetting('Bomby:', bombs, 3, (rows * columns ~/ 3),
                    Settings.setBombs) +
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EasyLevel().getButton(
                          _canChangeValues, setState, _reloadVariables),
                      MediumLevel().getButton(
                          _canChangeValues, setState, _reloadVariables),
                      HardLevel().getButton(
                          _canChangeValues, setState, _reloadVariables),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SwitchListTile(
                    title: const Text(
                      "Motyw klasyczny: ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    activeColor: Colors.orange,
                    value: useNumbers,
                    onChanged: (bool newValue) {
                      setState(() {
                        Settings.setUseNumbers(newValue);
                        useNumbers = Settings.getUseNumbers();
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text(
                      "Wibracje: ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    activeColor: Colors.orange,
                    value: Settings.getVibration(),
                    onChanged: (bool newValue) {
                      setState(() {
                        Settings.setVibration(newValue);
                      });
                    },
                  ),
                  const Spacer(),
                  Center(
                      child: FutureBuilder<String>(
                    future: _getVersionApp(),
                    builder: (context, snapshot) =>
                        Text("Wersja: ${snapshot.data.toString()}"),
                  ))
                ],
          ),
        ),
      ),
    );
  }
}
