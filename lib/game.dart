import 'package:flutter/material.dart';
import 'models/board.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int height = 10;
  int weight = 10;
  int bombs = 10;
  var board = Board();

  void _initialiseGame() {
    board = Board();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: const Color.fromRGBO(0, 255, 255, 0.5),
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
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.brown,
    );
  }

  void _gameOver() {
    print('GameOver!');
  }
}
