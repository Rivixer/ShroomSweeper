import 'dart:math';
import 'package:flutter/material.dart';

import 'board_field.dart';

class Board {
  final int _columnsNumber;
  final int _rowsNumber;
  final int _bombsNumber;
  late int _noClickedFields;
  //int flaggedFields = 0;
  bool _bombsGenerated = false;
  List<List<BoardField>>? _board;

  Board(this._rowsNumber, this._columnsNumber, this._bombsNumber) {
    _noClickedFields = _rowsNumber * _columnsNumber;
    _generateBoard();
  }

  bool isDefeat(int column, int row) => _board![row][column].hasBomb;

  bool isWin(int column, int row) {
    return _noClickedFields <= _bombsNumber;
  }

  void _generateBoard() {
    _board = List.generate(_rowsNumber,
        (_) => (List.generate(_columnsNumber, (_) => BoardField())));
  }

  void _generateBombs(int columnClicked, int rowClicked) {
    var random = Random();

    int bombsPlaced = 0;
    while (bombsPlaced < _bombsNumber) {
      int column = random.nextInt(_columnsNumber);
      int row = random.nextInt(_rowsNumber);

      if (_board![row][column].hasBomb ||
          column == columnClicked ||
          row == rowClicked) {
        continue;
      }

      _board![row][column].hasBomb = true;
      bombsPlaced++;
    }
    _bombsGenerated = true;
  }

  void _calculateBombsAround() {
    for (int row = 0; row < _rowsNumber; row++) {
      for (int column = 0; column < _columnsNumber; column++) {
        if (row < _columnsNumber - 1 &&
            column < _rowsNumber - 1 &&
            _board![row + 1][column + 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (row < _columnsNumber - 1 && _board![row + 1][column].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (row < _columnsNumber - 1 &&
            column > 0 &&
            _board![row + 1][column - 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (column < _rowsNumber - 1 && _board![row][column + 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (column > 0 && _board![row][column - 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (row > 0 &&
            column < _rowsNumber - 1 &&
            _board![row - 1][column + 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (row > 0 && column > 0 && _board![row - 1][column - 1].hasBomb) {
          _board![row][column].bombsAround++;
        }
        if (row > 0 && _board![row - 1][column].hasBomb) {
          _board![row][column].bombsAround++;
        }
      }
    }
  }

  void discoverBoard(int column, int row) {
    if (!_bombsGenerated) {
      _generateBombs(column, row);
      _calculateBombsAround();
    }
    if (column < 0 ||
        column == _columnsNumber ||
        row < 0 ||
        row == _rowsNumber) {
      return;
    }
    if (_board![row][column].clicked) return;
    _board![row][column].clicked = true;
    if (_board![row][column].bombsAround > 0) return;
    discoverBoard(column + 1, row + 1);
    discoverBoard(column + 1, row);
    discoverBoard(column + 1, row - 1);
    discoverBoard(column, row + 1);
    discoverBoard(column, row - 1);
    discoverBoard(column - 1, row + 1);
    discoverBoard(column - 1, row);
    discoverBoard(column - 1, row - 1);
  }

  Image getImage(int column, row) {
    if (!_board![row][column].clicked) {
      return Image.asset('lib/images/unclicked.png');
    }
    if (_board![row][column].hasBomb) {
      return Image.asset('lib/images/red_toadstool.png');
    }
    switch (_board![row][column].bombsAround) {
      case 1:
        return Image.asset('lib/images/1.png');
      case 2:
        return Image.asset('lib/images/1.png');
      case 3:
        return Image.asset('lib/images/1.png');
      case 4:
        return Image.asset('lib/images/1.png');
      case 5:
        return Image.asset('lib/images/1.png');
      case 6:
        return Image.asset('lib/images/1.png');
      case 7:
        return Image.asset('lib/images/1.png');
      case 8:
        return Image.asset('lib/images/1.png');
      default:
        return Image.asset('lib/images/clicked.png');
    }
  }
}
