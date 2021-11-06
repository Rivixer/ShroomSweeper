import 'package:flutter/material.dart';
import 'models/board.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int columnsNumber = 10;
  int rowsNumber = 10;
  int bombsNumber = 10;
  late Board board;

  void _initialiseGame() {
    board = Board(columnsNumber, rowsNumber, bombsNumber);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
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
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnsNumber,
              ),
              itemBuilder: (context, position) {
                int column = position % columnsNumber;
                int row = position ~/ columnsNumber;
                print('$column $row $position');
                Image image = board.getImage(column, row);

                return InkWell(
                  onTap: () {
                    board.discoverBoard(column, row);
                    if (board.isWin(column, row)) {
                      _handleWin();
                    } else if (board.isDefeat(column, row)) {
                      _handleGameOver();
                    }
                    setState(() {});
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    color: Colors.grey,
                    child: image,
                  ),
                );
              },
              itemCount: rowsNumber * columnsNumber),
        ],
      ),
      backgroundColor: Colors.brown,
    );
  }

  void _handleGameOver() {
    showDialog(
      context: context,
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
    showDialog(
      context: context,
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
