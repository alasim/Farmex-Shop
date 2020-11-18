import 'package:flutter/material.dart';

Widget typeCard(color, image, text) {
  return Container(
    width: 105,
    margin: EdgeInsets.only(
      left: 15,
    ),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Image(
            width: 50,
            image: AssetImage(image),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}
