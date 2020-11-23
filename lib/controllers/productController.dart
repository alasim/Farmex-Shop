import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authController.dart';
import 'dart:async';

class ProductController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Product> carted = RxList<Product>();
  RxList<Product> wishlisted = RxList<Product>();
  RxList<Product> vegetables = RxList<Product>();
  RxList<Product> fruits = RxList<Product>();
  var inCart = {}.obs;

  List<Order> orders2 = [
    Order([
      preProducts[0],
      preProducts[2],
      preProducts[5],
    ], {
      preProducts[0].name: 2,
      preProducts[2].name: 3,
      preProducts[5].name: 5,
    }, 'Paied'),
  ];

  Future<bool> addOrder(Map order) async {
    await _firestore
        .collection('Users')
        .doc(authController.user)
        .collection('Orders')
        .add(order)
        .then((newDocRef) async {
      print('New order saved');
      print('newDocRef.id');
      print(newDocRef.id);
      newDocRef.update({'id': newDocRef.id});
      addOrderPublic(order, newDocRef.id);
      return true;
    }).catchError((err) {
      Get.snackbar('Error to save new order', err.message);
      return false;
    });
  }

  Future<bool> addOrderPublic(Map order, String id) async {
    await _firestore.collection('Orders').add(order).then((newDocRef) async {
      print('New public order saved');
      newDocRef.update({'pulickKey': newDocRef.id, 'id': id});
      return true;
    }).catchError((err) {
      Get.snackbar('Error to save new order', err.message);
      return false;
    });
  }

  Future<List<OrderModel>> get orders async {
    List<OrderModel> _orders = [];
    await _firestore
        .collection('Users')
        .doc(authController.user)
        .collection('Orders')
        .orderBy('timestamp')
        .get()
        .then(
          (qSnapshot) => qSnapshot.docs.forEach(
            (element) {
              var item = OrderModel.fromQsnapshot(element, element.id);
              _orders.add(item);
            },
          ),
        );
    // print('_orders.length');
    // print(_orders.length);

    return _orders;
  }
}

final productController = ProductController();
