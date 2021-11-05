import 'dart:math';
import 'board_field.dart';

class Board {
  final int _height;
  final int _weight;
  final int _bombs;
  List<List<BoardField>>? _board;

  Board([this._height = 10, this._weight = 10, this._bombs = 10]) {
    initialiseGame();
  }

  void initialiseGame() {
    _generateBoard();
    _generateBombs();
  }

  void _generateBoard() {
    _board = List.generate(
        _height, (_) => (List.generate(_weight, (_) => BoardField())));
  }

  void _generateBombs() {
    var random = Random();

    int i = 0;
    while (i < _bombs) {
      int x = random.nextInt(_weight);
      int y = random.nextInt(_height);

      if (_board![x][y].hasBomb) {
        continue;
      }

      _board![x][y].hasBomb = true;
      i++;
    }
  }
}
