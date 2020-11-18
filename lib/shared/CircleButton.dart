import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  const CircleButton(this.icon, this.onTap, [this.size = 27]);
  final icon;
  final Function onTap;
  final double size;

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: widget.size, end: widget.size + 3),
          weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: widget.size + 3, end: widget.size),
          weight: 50),
    ]).animate(_controller);
    _sizeAnimation.addListener(() {
      //print(_sizeAnimation.value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return GestureDetector(
          onTap: () {
            print('b status: ${_controller.status}');
            _controller.forward();

            widget.onTap();
          },
          child: Container(
            width: _sizeAnimation.value,
            height: _sizeAnimation.value,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [
                  Color(0xffA8DE1C),
                  Color(0xff92D61B),
                ],
              ),
            ),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 17,
            ),
          ),
        );
      },
    );
  }
}
