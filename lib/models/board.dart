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
  }

  void _generateBoard() {
    _board = List.generate(
        _height, (_) => (List.generate(_weight, (_) => BoardField())));
  }
}
