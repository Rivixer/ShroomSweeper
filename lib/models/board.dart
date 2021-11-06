import 'dart:math';
import 'package:flutter/material.dart';

import 'board_field.dart';

class Board {
  final int _height;
  final int _weight;
  final int _bombs;
  List<List<BoardField>>? _board;
  bool _bombsGenerated = false;

  Board([this._height = 10, this._weight = 10, this._bombs = 10]) {
    _generateBoard();
  }

  void handleClick(int x, int y) => _board![x][y].clicked = true;

  bool hasBomb(int x, int y) => _board![x][y].hasBomb;

  void _generateBoard() {
    _board = List.generate(
        _height, (_) => (List.generate(_weight, (_) => BoardField())));
  }

  void _generateBombs(int xClicked, int yClicked) {
    var random = Random();

    int i = 0;
    while (i < _bombs) {
      int x = random.nextInt(_weight);
      int y = random.nextInt(_height);

      if (_board![x][y].hasBomb || x == xClicked || y == yClicked) {
        continue;
      }

      _board![x][y].hasBomb = true;
      i++;
    }
    _bombsGenerated = true;
  }

  void _calculateBombsAround() {
    for (int x = 0; x < _weight; x++) {
      for (int y = 0; y < _height; y++) {
        if (x < _weight - 1 &&
            y < _height - 1 &&
            _board![x + 1][y + 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (x < _weight - 1 && _board![x + 1][y].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (x < _weight - 1 && y > 0 && _board![x + 1][y - 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (y < _height - 1 && _board![x][y + 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (y > 0 && _board![x][y - 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (x > 0 && y < _height - 1 && _board![x - 1][y + 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (x > 0 && y > 0 && _board![x - 1][y - 1].hasBomb) {
          _board![x][y].bombsAround++;
        }
        if (x > 0 && _board![x - 1][y].hasBomb) {
          _board![x][y].bombsAround++;
        }
      }
    }
  }

  void discoverBoard(int x, int y) {
    if (!_bombsGenerated) {
      _generateBombs(x, y);
      _calculateBombsAround();
    }
    if (x < 0 || x == _weight || y < 0 || y == _height) return;
    if (_board![x][y].hasBomb) return;
    if (_board![x][y].clicked) return;
    _board![x][y].clicked = true;
    if (_board![x][y].bombsAround > 0) return;
    discoverBoard(x + 1, y + 1);
    discoverBoard(x + 1, y);
    discoverBoard(x + 1, y - 1);
    discoverBoard(x, y + 1);
    discoverBoard(x, y - 1);
    discoverBoard(x - 1, y + 1);
    discoverBoard(x - 1, y);
    discoverBoard(x - 1, y - 1);
  }

  Image getImage(int x, int y) {
    if (!_board![x][y].clicked) {
      return Image.asset('lib/images/unclicked.png');
    }
    if (_board![x][y].hasBomb) {
      return Image.asset('lib/images/red_toadstool.png');
    }
    switch (_board![x][y].bombsAround) {
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
