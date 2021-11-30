import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'package:minesweeper/models/board_field.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/pages/settings_page/settings_page.dart';
import 'package:minesweeper/utils/settings.dart';

import './game_page_widgets/game_page_bombs_left.dart';
import './game_page_widgets/game_page_end_game.dart';
import './game_page_widgets/game_page_images.dart';
import './game_page_widgets/game_page_settings_icon.dart';
import './game_page_widgets/game_page_smiley_face.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _isSnackBarActivate = false;
  int columns = Settings.getColumns();
  int rows = Settings.getRows();
  int bombs = Settings.getBombs();
  bool? inGame;
  late Board board;

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  void _initialiseGame() {
    columns = Settings.getColumns();
    rows = Settings.getRows();
    bombs = Settings.getBombs();
    board = Board(columns, rows, bombs);
    inGame = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            height: 80.0,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                getBombLeftWidget(bombs, board.getFlaggedFieldsNumber()),
                getSmileyFaceWidget(() => _initialiseGame()),
                getSettingsIconWidget(
                  context,
                  () async {
                    final isBoardChanged = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          inGame: inGame,
                        ),
                      ),
                    );
                    setState(
                      () {
                        if (isBoardChanged ?? false) {
                          _initialiseGame();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(1.0),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                  ),
                  itemBuilder: (context, position) => _getItemBuilder(position),
                  itemCount: rows * columns,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell _getItemBuilder(position) {
    int column = position % columns;
    int row = position ~/ columns;
    BoardField boardField = board.getBoardField(column, row);
    Image image = Images.getBoardFieldImage(boardField, inGame ?? false);

    void checkEndGame() {
      if (board.isDefeat(column, row)) {
        inGame = false;
        handleGameOver(context, _initialiseGame);
      } else if (board.isWin(column, row)) {
        inGame = false;
        handleWin(context, _initialiseGame);
      }
    }

    if (inGame == false) return InkWell(child: image);
    if (board.isFlagged(column, row)) {
      return InkWell(
        onTap: () {
          const snackBar = SnackBar(
            content:
                Text('Kliknij dwukrotnie, by odkryć pole oznaczone flagą!'),
            duration: Duration(seconds: 3),
          );
          if (!_isSnackBarActivate) {
            _isSnackBarActivate = true;
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar)
                .closed
                .then((value) => _isSnackBarActivate = false);
          }
        },
        onLongPress: () {
          if (Settings.getVibration()) {
            Vibration.vibrate(duration: 25);
          }
          board.setFlag(column, row);
          setState(() {});
        },
        onDoubleTap: () {
          board.discoverBoard(column, row);
          checkEndGame();
          setState(() {});
        },
        child: image,
      );
    }
    return InkWell(
      onTap: () {
        inGame ??= true;
        board.discoverBoard(column, row);
        checkEndGame();
        setState(() {});
      },
      onLongPress: () {
        if (inGame == null || board.isClicked(column, row)) {
          return;
        }
        if (Settings.getVibration()) {
          Vibration.vibrate(duration: 25);
        }
        board.setFlag(column, row);
        setState(() {});
      },
      child: image,
    );
  }
}
