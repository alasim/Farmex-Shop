import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getProducts() async {
    var snapshot = await _firestore.collection('Products').get();
    return snapshot;
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
}
