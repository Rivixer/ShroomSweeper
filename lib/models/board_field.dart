class BoardField {
  bool hasBomb;
  int bombsAround;
  bool opened = false;

  BoardField({this.hasBomb = false, this.bombsAround = 0});
}
