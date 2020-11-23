import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  String userId;
  String publicKey;
  String date;
  int timestamp;
  Map inCart;
  bool paied;
  int payable;
  OrderModel.fromQsnapshot(QueryDocumentSnapshot e, String key) {
    this.id = e.data()['id'];
    this.userId = e.data()['userId'];
    this.date = e.data()['date'];
    this.timestamp = e.data()['timestamp'];
    this.paied = e.data()['paied'];
    this.payable = e.data()['payable'];
    this.inCart = e.data()['items'];
    this.publicKey = key;
    //confusion about the key
  }
  // reading orders from database
  OrderModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc)
      : id = doc.data()['id'],
        userId = doc.data()['userId'],
        date = doc.data()['date'],
        timestamp = doc.data()['timestamp'],
        paied = doc.data()['paied'],
        payable = doc.data()['payable'],
        inCart = doc.data()['items'];
}
