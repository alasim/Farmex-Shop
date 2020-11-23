import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FulWithButton extends StatefulWidget {
  FulWithButton({this.buttonHandle, this.text});
  final Function buttonHandle;
  final text;
  @override
  _FulWithButtonState createState() => _FulWithButtonState();
}

class _FulWithButtonState extends State<FulWithButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 3),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffA8DE1C), Color(0xff50AC02)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.buttonHandle();
          },
          child: Center(
            child: Text(widget.text,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
