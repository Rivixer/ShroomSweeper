import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void setColumns(int columns) async =>
      await _preferences.setInt('columns', columns);

  static int getColumns() => _preferences.getInt('columns') ?? 6;

  static void setRows(int rows) async =>
      await _preferences.setInt('rows', rows);

  static int getRows() => _preferences.getInt('rows') ?? 8;

  static void setBombs(int bombs) async =>
      await _preferences.setInt('bombs', bombs);

  static int getBombs() => _preferences.getInt('bombs') ?? 5;

  static void setUseNumbers(bool value) async =>
      await _preferences.setBool('useNumbers', value);

  static bool getUseNumbers() => _preferences.getBool('useNumbers') ?? false;

  static void setVibration(bool value) async =>
      await _preferences.setBool('vibration', value);

  static bool getVibration() => _preferences.getBool('vibration') ?? true;
}
