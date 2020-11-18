import 'package:farmex_shop/models/datas.dart';

import '../models/constants.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  Heart({@required this.p, this.refreshParent});
  final Function refreshParent;
  final Product p;
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _colorAnimation;
  Animation _sizeAimation;
  bool isWish = false;

  @override
  void initState() {
    super.initState();
    isWish = wishlisted.contains(widget.p);
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _colorAnimation =
        ColorTween(begin: Colors.grey[300], end: kDeepGeen.withOpacity(.8))
            .animate(_controller);
    _sizeAimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 25, end: 30), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 25), weight: 50),
    ]).animate(_controller);
    _controller.addListener(() {
      print(_sizeAimation.value);
      print(_colorAnimation.value);
    });
    _colorAnimation.addStatusListener((status) {
      isWish = status == AnimationStatus.completed ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAimation.value,
            ),
            onPressed: () {
              isWish ? _controller.reverse() : _controller.forward();
              if (isWish) wishlisted.remove(widget.p);
              widget.p.loved = true;
              if (!isWish) wishlisted.add(widget.p);
            });
      },
    );
  }
}
