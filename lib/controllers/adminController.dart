import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authController.dart';
import 'dart:async';

class AdminController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderModel>> get orders async {
    List<OrderModel> _orders = [];
    await _firestore.collection('Orders').get().then((snapshot) {
      snapshot.docs.forEach((e) {
        if (!e.data()['paied']) _orders.add(OrderModel.fromQsnapshot(e, e.id));
      });
    });

    print('_orders.length');
    print(_orders.length);

    return _orders;
  }

  Future<bool> makePaied({String userId, String id, String publicKey}) async {
    print('ids to update');
    print('userId');
    print(userId);
    print('id');
    print(id);
    print('publicKey');
    print(publicKey);
    _firestore.collection('Orders').doc(publicKey).update({'paied': true}).then(
      (value) {
        _firestore
            .collection('Users')
            .doc(userId)
            .collection('Orders')
            .doc(id)
            .update({'paied': true})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update public: $error"));
      },
    ).catchError((error) => print("Failed to update user: $error"));
    return false;
  }
}

final adminController = AdminController();
