import 'package:flutter/material.dart';
import 'package:minesweeper/utils/settings.dart';
import 'settings_page_widgets/settings_page_alerts.dart';
import 'settings_page_widgets/settings_page_app_info.dart';
import 'settings_page_widgets/settings_page_board_settings.dart';
import 'settings_page_widgets/settings_page_classic_theme_settings.dart';
import 'settings_page_widgets/settings_page_default_level_settings.dart';
import 'settings_page_widgets/settings_page_vibration_settings.dart';

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
  late bool? inGame = widget.inGame;

  void _reloadVariables() {
    bombs = Settings.getBombs();
    columns = Settings.getColumns();
    rows = Settings.getRows();
  }

  Future<bool> _canChangeValues() async {
    if (inGame != true ||
        (await Alerts.showResetWhenSettingsAreChanged(context) ?? false)) {
      inGame = null;
      boardChanged = true;
      return true;
    }
    return false;
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
            children: <Widget>[
              getBoardSettingListTile('Kolumny:', columns),
              getBoardSettingSlider(columns, 3, 12, (newValue) async {
                if (await _canChangeValues()) {
                  setState(() {
                    if (bombs > rows * newValue.toInt() ~/ 3) {
                      Settings.setBombs(rows * newValue.toInt() ~/ 3);
                    }
                    Settings.setColumns(newValue.toInt());
                    _reloadVariables();
                  });
                }
              }),
              getBoardSettingListTile('Wiersze:', rows),
              getBoardSettingSlider(rows, 3, 50, (newValue) async {
                if (await _canChangeValues()) {
                  setState(() {
                    if (bombs > newValue.toInt() * columns ~/ 3) {
                      Settings.setBombs(newValue.toInt() * columns ~/ 3);
                    }
                    Settings.setRows(newValue.toInt());
                    _reloadVariables();
                  });
                }
              }),
              getBoardSettingListTile('Bomby:', bombs),
              getBoardSettingSlider(bombs, 3, (rows * columns ~/ 3),
                  (newValue) async {
                if (await _canChangeValues()) {
                  setState(() {
                    if (newValue > rows * columns) {
                      Settings.setBombs(rows * columns ~/ 3);
                    } else {
                      Settings.setBombs(newValue.toInt());
                    }
                    _reloadVariables();
                  });
                }
              }),
              getDefaultLevelButtons(
                  _canChangeValues, setState, _reloadVariables),
              const SizedBox(height: 15),
              getUseClassicThemeSwitch(setState),
              getUseVibrationSwitch(setState),
              const Spacer(),
              getAppVersionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
