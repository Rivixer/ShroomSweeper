import 'package:flutter/material.dart';
import 'game_page_images.dart';

Row getBombLeftWidget(int bombs, int flaggedFields) {
  return Row(
    children: [
      Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: Images.getTransparentBombImage(),
        ),
      ),
      Center(
        child: Text(
          (bombs - flaggedFields).toString(),
          style: TextStyle(
            fontSize: 20,
            shadows: [
              Shadow(
                offset: Offset.fromDirection(1.1),
                blurRadius: 0.1,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
