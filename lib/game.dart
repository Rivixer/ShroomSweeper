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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: ListView(
        children: [
          Container(
            color: const Color.fromRGBO(12, 200, 55, 0.9),
            height: 80.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print(':)');
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.brown,
                    radius: 25,
                    child: Icon(
                      Icons.tag_faces,
                      color: Colors.yellowAccent,
                      size: 50.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
