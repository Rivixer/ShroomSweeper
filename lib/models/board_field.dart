import 'dart:math';

class BoardField {
  bool hasBomb;
  bool clicked = false;
  bool flagged = false;
  int bombsAround;
  int pngNumber = 0;

  BoardField({this.hasBomb = false, this.bombsAround = 0}) {
    var random = Random();
    int number = random.nextInt(15);
    if (number > 5) {
      number = 0;
    }
    pngNumber = number;
  }
}
