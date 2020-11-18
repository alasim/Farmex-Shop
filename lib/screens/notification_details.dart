import 'package:farmex_shop/models/datas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  NotificationDetails(this.n);
  final NotificationContent n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 35,
            color: Colors.grey,
          ),
        ),
        title: Text(
          n.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              n.image,
              width: double.infinity,
            ),
            SizedBox(height: 20),
            n.description,
          ],
        ),
      ),
    );
  }
}
