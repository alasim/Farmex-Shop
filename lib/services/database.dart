import 'dart:io';

import '../models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    var snapshot = await _firestore.collection('Products').get();
    List<Product> data = snapshot.docs
        .map((e) => Product(
            type: e.data()['producType'] == 'vegetable'
                ? types.vegetable
                : e.data()['producType'] == 'fruit'
                    ? types.fruit
                    : types.mortar,
            name: e.data()['producName'],
            image: e.data()['imageUrl'],
            itemQuantity: e.data()['productUnit'],
            price: int.parse(e.data()['producPrice']),
            theme:
                e.data()['producTheme'] == 'green' ? greenTheme : orangeTheme))
        .toList();

    return data;
  }

  Future<String> upluadImage(
      File imageFile, String fileName, Map<String, dynamic> data) async {
    // all image can be upload by changing the path filename
    Reference _firebaseStorageRef =
        await FirebaseStorage.instance.ref().child('ProductImages/$fileName');
    UploadTask uploadTask = _firebaseStorageRef.putFile(imageFile);
    String imageUrl;
    uploadTask.whenComplete(() async {
      try {
        imageUrl = await _firebaseStorageRef.getDownloadURL();
        data['imageUrl'] = imageUrl;
        await _firestore
            .collection('Products')
            .add(data)
            .then((value) => true)
            .catchError((err) => false);
        print('imageUrl from database upload file');
        print(imageUrl);
        return imageUrl;
      } catch (onError) {
        print("Error");
        return null;
      }
    });
    return null;
  }

  productUploadOnce(Map data) {
    _firestore.collection('Products').add(data).then((doc) async {
      await _firestore
          .collection('Products')
          .doc(doc.id)
          .update({'id': doc.id});
    }).catchError((err) => false);
  }
}
