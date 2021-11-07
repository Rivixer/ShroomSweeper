import 'package:flutter/material.dart';
import 'package:minesweeper/utils/settings.dart';
import 'package:minesweeper/pages/settings_page.dart';
import 'models/board.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int columns = Settings.getColumns();
  int rows = Settings.getRows();
  int bombs = Settings.getBombs();
  bool inGame = false;
  late Board board;

  void _initialiseGame() {
    columns = Settings.getColumns();
    rows = Settings.getRows();
    bombs = Settings.getBombs();
    board = Board(columns, rows, bombs);
    inGame = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            height: 80.0,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(),
                    Center(
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.settings),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                          setState(() {
                            _initialiseGame();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      _initialiseGame();
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.tag_faces,
                        color: Colors.yellowAccent,
                        size: 50.0,
                      ),
                      backgroundColor: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
              ),
              itemBuilder: (context, position) {
                int column = position % columns;
                int row = position ~/ columns;
                Image image = board.getImage(column, row);

                return InkWell(
                  onTap: () {
                    if (!inGame) return;
                    board.discoverBoard(column, row);
                    if (board.isWin(column, row)) {
                      _handleWin();
                    } else if (board.isDefeat(column, row)) {
                      _handleGameOver();
                    }
                    setState(() {});
                  },
                  onLongPress: () {
                    if (!inGame) return;
                    board.setFlag(column, row);
                    setState(() {});
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    color: Colors.grey,
                    child: image,
                  ),
                );
              },
              itemCount: rows * columns),
        ],
      ),
      backgroundColor: Colors.brown,
    );
  }

  void _handleGameOver() {
    inGame = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Przegrywasz!"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _initialiseGame();
                  Navigator.pop(context);
                },
                child: const Text("Spróbuj ponownie!")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ukryj!"))
          ],
        );
      },
    );
  }

  void _handleWin() {
    inGame = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Wygrywasz!"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _initialiseGame();
                  Navigator.pop(context);
                },
                child: const Text("Jeszcze raz!")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ukryj!"))
          ],
        );
      },
    );
  }
}
