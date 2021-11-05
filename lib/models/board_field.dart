class BoardField {
  bool hasBomb;
  int bombsAround;
  bool clicked = false;

  BoardField({this.hasBomb = false, this.bombsAround = 0});
}
