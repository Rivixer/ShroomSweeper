import 'package:flutter/material.dart';

Center getSmileyFaceWidget(void Function() onTap) {
  return Center(
    child: InkWell(
      onTap: onTap,
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
  );
}
