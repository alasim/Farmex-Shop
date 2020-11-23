import 'package:flutter/material.dart';
import '../../constants/button_themes.dart';

class FButton extends StatelessWidget {
  final Function onPressed;
  final text;
  final Color color;
  FButton({this.text, this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        color: color,
        onPressed: onPressed,
        child: Text(
          text,
          style: kWhiteText,
        ),
      ),
    );
  }
}
