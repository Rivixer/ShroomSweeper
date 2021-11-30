import 'package:flutter/material.dart';
import 'package:minesweeper/models/board_field.dart';
import 'package:minesweeper/utils/settings.dart';

class Images {
  static Image getImage(String name) {
    bool useNumbers = Settings.getUseNumbers();
    String folder = 'assets/images/${useNumbers ? "numbers" : "shrooms"}';
    return Image.asset(
      '$folder/$name.png',
      gaplessPlayback: true,
    );
  }

  static Image getBoardFieldImage(BoardField boardField, bool inGame) {
    if (!boardField.clicked) {
      if (boardField.flagged) {
        if (!inGame && !boardField.hasBomb) {
          return Images.getImage('broken_flag');
        }
        return Images.getImage('flag');
      }
      if (!inGame && boardField.hasBomb) {
        return Images.getImage('unclicked_bomb');
      }
      bool useNumbers = Settings.getUseNumbers();
      return Images.getImage(
          'unclicked${useNumbers ? "" : boardField.pngNumber}');
    }
    if (boardField.hasBomb) {
      return Images.getImage('clicked_bomb');
    }
    if (boardField.bombsAround > 0) {
      return Images.getImage(boardField.bombsAround.toString());
    }
    return Images.getImage('clicked');
  }

  static Image getTransparentBombImage() => Images.getImage('transparent_bomb');
}
