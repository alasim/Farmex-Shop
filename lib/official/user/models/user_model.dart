import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String photoURL;
  String phone;
  String address;
  Map<String, String> info = {}; //didn't use yet and confused to use it

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.photoURL,
  });

  UserModel.fromDocumentSnashot(DocumentSnapshot doc)
      : name = doc.data()['name'],
        email = doc.data()['email'],
        photoURL = doc.data()['photoURL'],
        phone = doc.data()['phone'],
        address = doc.data()['address'];
}
