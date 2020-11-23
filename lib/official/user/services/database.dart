import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import 'package:get/get.dart';
import 'dart:io';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // auth user area start
  Future<bool> createDatabase({String name, String email, String uid}) async {
    try {
      await _firestore.collection('Users').doc(uid).set({
        'name': name,
        'email': email,
      });
      return true;
    } catch (e) {
      Get.snackbar(
        'Error from database',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // need to check create but check if present or not, mainly google signing facet
  Future<bool> isDatabasePresent(String uid) async {
    try {
      var users = await _firestore.collection('Users').get();
      users.docs.forEach((element) {
        if (element.id == uid) return true;
      });
      return false;
    } catch (e) {
      Get.snackbar(
        'Error from database',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<DocumentSnapshot> getDatabase(String uid) async {
    try {
      var users = await _firestore.collection('Users').doc(uid).get();
      return users;
    } catch (e) {
      Get.snackbar(
        'Error from database',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  } // auth user area end -----------------------------------------------------------------------------------------

  //product area start
  Future<bool> addProduct(
      File imageFile, String fileName, Map<String, dynamic> data) async {
    Reference _ref =
        await FirebaseStorage.instance.ref().child('ProductImages/$fileName');
    UploadTask uploadTask = _ref.putFile(imageFile);
    String imageUrl;
    uploadTask.whenComplete(() async {
      try {
        imageUrl = await _ref.getDownloadURL();
        data['imageUrl'] = imageUrl;
        await _firestore
            .collection('Products')
            .add(data)
            .then((value) => true)
            .catchError((err) => false);
        print('imageUrl from database upload file');
        print(imageUrl);
        return true;
      } catch (onError) {
        print("Error");
        return false;
      }
    });
    return false;
  }

  Stream<List<ProductModel>> getProductList() {
    return _firestore.collection('Products').snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => ProductModel.fromQueryDocumentSnapshot(document))
            .toList());
  }

  productUploadOnce(Map data) {
    // upload etier list
    _firestore.collection('Products').add(data).then((doc) async {
      await _firestore
          .collection('Products')
          .doc(doc.id)
          .update({'id': doc.id});
    }).catchError((err) => false);
  }
  //product area end----------------------------------------------------------------------------

  // Order management area
  Stream<List<OrderModel>> getOrderList() {
    return _firestore.collection('Orders').snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => OrderModel.fromQueryDocumentSnapshot(document))
            .toList());
  }
}
