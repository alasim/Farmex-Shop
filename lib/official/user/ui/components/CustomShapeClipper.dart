import 'package:flutter/material.dart';

class MyCustomPaint extends CustomPainter {
  final Color mainColor1;
  final Color mainColor2;
  final Color color1;
  final Color color2;
  MyCustomPaint(this.mainColor1, this.mainColor2, this.color1, this.color2);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, 3 * size.height / 4.5, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [.3, .9],
      colors: [
        mainColor1,
        mainColor2,
      ],
    ).createShader(
      Rect.fromCircle(
        center: Offset(15, 15),
        radius: 50,
      ),
    );
    canvas.drawPath(path, paint);

    Path circle1 = Path();
    circle1.addOval(
      Rect.fromLTWH(-90, size.height - 210, 182, 182),
    );
    paint.shader = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        color1,
        color2,
      ],
    ).createShader(
      Rect.fromCircle(
        center: Offset(15, 15),
        radius: 50,
      ),
    );
    canvas.drawPath(circle1, paint);

    Path circle2 = Path();
    circle2.addOval(
      Rect.fromLTWH(size.width * .60, size.height - 220, 210, 210),
    );
    paint.shader = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        //Color(0xffFC9000),
        color1,
        color2,
      ],
    ).createShader(
      Rect.fromCircle(
        center: Offset(15, 15),
        radius: 50,
      ),
    );
    canvas.drawPath(circle2, paint);

    // Path notibox = Path();
    // notibox.moveTo(0, 0);
    // notibox.lineTo(0, 25);
    // notibox.lineTo(size.width, 25);
    // notibox.lineTo(size.width, 0);
    // notibox.close();
    // paint.shader = LinearGradient(
    //   begin: Alignment.topCenter,
    //   end: Alignment.bottomCenter,
    //   colors: [
    //     //Color(0xffFC9000),
    //     Colors.green,
    //     Colors.green,
    //   ],
    // ).createShader(
    //   Rect.fromCircle(
    //     center: Offset(15, 15),
    //     radius: 50,
    //   ),
    // );
    // canvas.drawPath(notibox, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
