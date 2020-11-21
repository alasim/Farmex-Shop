import 'package:farmex_shop/controllers/adminController.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/adminOrderDetails.dart';
import 'package:farmex_shop/screens/adminOrders.dart';
import 'package:farmex_shop/screens/adminProductUpload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    adminController.orders;

    preProducts.forEach((e) => priceSet[e.name] = e.price);
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Area'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(0),
                child: FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    Get.to(AdminOrders());
                  },
                  child: Text(
                    'See Unpaied Orders',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    Get.to(AdminProductUpload());
                  },
                  child: Text(
                    'Add New Product',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
