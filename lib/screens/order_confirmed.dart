import 'package:farmex_shop/main.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/adminOrders.dart';
import 'package:farmex_shop/screens/home_screen.dart';
import 'package:farmex_shop/screens/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/productController.dart';

class OrderConfirmed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  size: 200,
                  color: kDeepGeen,
                ),
                Text(
                  'Your order confirmed.',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
                SizedBox(height: 150),
                RaisedButton(
                  child: Text('User orders'),
                  onPressed: () {
                    Get.to(OrdersScreen());
                  },
                ),
                RaisedButton(
                  child: Text('Admin orders'),
                  onPressed: () {
                    Get.to(AdminOrders());
                  },
                ),
                RaisedButton(
                  child: Text('Back to home'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
