import 'package:flutter/material.dart';
import 'package:minesweeper/utils/settings.dart';

class DefaultLevels {
  void _setLevel(int columns, int rows, int bombs) {
    Settings.setColumns(columns);
    Settings.setRows(rows);
    Settings.setBombs(bombs);
  }

  bool _isThisLevel(int columns, int rows, int bombs) {
    return columns == Settings.getColumns() &&
        rows == Settings.getRows() &&
        bombs == Settings.getBombs();
  }

  ElevatedButton _getButton(String level, bool thisLevel, Function setLevel,
      Function canChangeValues, Function setState, Function reloadVariables) {
    return ElevatedButton(
      onPressed: () async {
        if (await canChangeValues()) {
          setState(
            () {
              setLevel();
              reloadVariables();
            },
          );
        }
      },
      child: Text(level),
      style: ElevatedButton.styleFrom(
        primary: thisLevel ? Colors.brown[800] : Colors.orange,
        onPrimary: thisLevel ? Colors.orange : Colors.brown[800],
        alignment: Alignment.center,
      ),
    );
  }
}

class EasyLevel extends DefaultLevels {
  int columns = 6;
  int rows = 8;
  int bombs = 5;

  void setLevel() => _setLevel(columns, rows, bombs);

  ElevatedButton getButton(
      Function canChangeValues, Function setState, Function reloadVariables) {
    bool thisLevel = super._isThisLevel(columns, rows, bombs);
    return super._getButton('ŁATWY', thisLevel, setLevel, canChangeValues,
        setState, reloadVariables);
  }
}

class MediumLevel extends DefaultLevels {
  int columns = 10;
  int rows = 14;
  int bombs = 20;

  void setLevel() => super._setLevel(columns, rows, bombs);

  ElevatedButton getButton(
      Function canChangeValues, Function setState, Function reloadVariables) {
    bool thisLevel = super._isThisLevel(columns, rows, bombs);
    return super._getButton('ŚREDNI', thisLevel, setLevel, canChangeValues,
        setState, reloadVariables);
  }
}

class HardLevel extends DefaultLevels {
  int columns = 12;
  int rows = 21;
  int bombs = 45;

  void setLevel() => super._setLevel(columns, rows, bombs);

  ElevatedButton getButton(
      Function canChangeValues, Function setState, Function reloadVariables) {
    bool thisLevel = super._isThisLevel(columns, rows, bombs);
    return super._getButton('TRUDNY', thisLevel, setLevel, canChangeValues,
        setState, reloadVariables);
  }
}
