import 'package:minesweeper/utils/settings.dart';

class DefaultLevels {
  void _setLevel(int columns, int rows, int bombs) {
    Settings.setColumns(columns);
    Settings.setRows(rows);
    Settings.setBombs(bombs);
  }
}

class EasyLevel extends DefaultLevels {
  int columns = 6;
  int rows = 8;
  int bombs = 5;

  void setLevel() => _setLevel(columns, rows, bombs);

  bool isThisLevel(int columns, int rows, int bombs) {
    return this.columns == columns && this.rows == rows && this.bombs == bombs;
  }
}

class MediumLevel extends DefaultLevels {
  int columns = 10;
  int rows = 14;
  int bombs = 20;

  void setLevel() => super._setLevel(columns, rows, bombs);

  bool isThisLevel(int columns, int rows, int bombs) {
    return this.columns == columns && this.rows == rows && this.bombs == bombs;
  }
}

class HardLevel extends DefaultLevels {
  int columns = 12;
  int rows = 21;
  int bombs = 45;

  void setLevel() => super._setLevel(columns, rows, bombs);

  bool isThisLevel(int columns, int rows, int bombs) {
    return this.columns == columns && this.rows == rows && this.bombs == bombs;
  }
}
