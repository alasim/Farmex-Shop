import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmex_shop/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './product.dart';
import './constants.dart';

enum types { vegetable, fruit, mortar }
Map<String, int> priceSet = {};
//need for online persing
List<Product> preProducts = [
  Product(
      type: types.mortar,
      name: 'Broccoli ',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2070.png?alt=media&token=16b9963a-4c42-40c1-81d9-9233de78d69a',
      itemQuantity: '1p',
      price: 5,
      theme: orangeTheme),
  Product(
      type: types.mortar,
      name: 'Capsicum yellow',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2066.png?alt=media&token=a6b3715c-b451-4f0f-a2ad-2ea29c0cfd3e',
      itemQuantity: '1p',
      price: 5,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Cabbage',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2043.png?alt=media&token=e02145f5-be23-4850-bdc2-46ee6490bc69',
      itemQuantity: '1kg',
      price: 40,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Strawberry',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2013.png?alt=media&token=c7a89abb-c151-4a9a-ae88-074b0c327d7d',
      itemQuantity: '100g',
      price: 40,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Mango',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2021.png?alt=media&token=00073189-1467-4523-8279-597e0c03c93d',
      itemQuantity: '1kg',
      price: 10,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Cucumber',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2079.png?alt=media&token=41ca2eaf-1129-4c86-9316-7bf4a99fd465',
      itemQuantity: '1kg',
      price: 55,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Orange',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2017.png?alt=media&token=05432ebb-dd3e-4e5d-a582-6004fd883597',
      itemQuantity: '1kg',
      price: 220,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Potato',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2069.png?alt=media&token=4d49144b-2483-4f6d-bb0b-27da68e0063c',
      itemQuantity: '1kg',
      price: 40,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Tomato',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2042.png?alt=media&token=6f9c268c-d2e9-4d5c-9289-0e7bccd5890e',
      itemQuantity: '1kg',
      price: 55,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Apple',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2041.png?alt=media&token=b9f978b9-945f-41cd-8a76-b5b10bda7774',
      itemQuantity: '1kg',
      price: 180,
      theme: orangeTheme),
  Product(
      type: types.fruit,
      name: 'Annar',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2015.png?alt=media&token=47228244-94c1-4910-99ae-529631471054',
      itemQuantity: '1kg',
      price: 350,
      theme: orangeTheme),
  Product(
      type: types.fruit,
      name: 'Papaya',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2016.png?alt=media&token=a90887e6-ca88-488c-93b4-67a3093818bf',
      itemQuantity: '1p',
      price: '1kg',
      theme: orangeTheme),
  Product(
      type: types.fruit,
      name: 'Pineaple',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%208.png?alt=media&token=bcae7e24-5dfe-49da-9bde-dbed8db018f5',
      itemQuantity: '1p',
      price: 25,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Green Lemon',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2022.png?alt=media&token=aca6e077-d154-4065-9778-c9ded64acd5b',
      itemQuantity: '12p',
      price: 5,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Banana',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2038.png?alt=media&token=4deea8e7-44b0-4a0d-802d-bcb9f085a958',
      itemQuantity: '12p',
      price: 90,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Guava',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2025.png?alt=media&token=5d14cb98-29ee-401a-9918-d0310343927e',
      itemQuantity: '1kg',
      price: 70,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Red Chili',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2071.png?alt=media&token=dc9aff1f-0cc7-4a3d-885b-1fbebfe6eb14',
      itemQuantity: '1kg',
      price: 20,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Green Broccoli',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2078.png?alt=media&token=2bee6570-d5d9-452c-8047-72e3d3cc7353',
      itemQuantity: '1p',
      price: 7,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Salad Leaf',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2072.png?alt=media&token=256f6f2e-c0cc-45a6-922a-6847366c4b67',
      itemQuantity: '1p',
      price: 3,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Cauliflower',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2075.png?alt=media&token=8c057c63-fdef-42d5-a0e4-14d5f94f26bf',
      itemQuantity: '1p',
      price: 45,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Date',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2035.png?alt=media&token=053e1cc5-297d-4bda-b1fe-a58ec5bf3376',
      itemQuantity: '1kg',
      price: 520,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Black Grape',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2033.png?alt=media&token=c0fcb4a0-3f8d-44aa-9c41-1a185034aa33',
      itemQuantity: '1kg',
      price: 280,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Grape',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2034.png?alt=media&token=2ae79340-0a1c-4d0d-9d8a-f36fbe6e7dbb',
      itemQuantity: '1kg',
      price: 250,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Green Mango',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2027.png?alt=media&token=c15207d8-fd78-42c4-9884-6878718d5031',
      itemQuantity: '1kg',
      price: 10,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Onion',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2076.png?alt=media&token=df7db922-bc72-4f4e-9f1b-0f9f8b24b571',
      itemQuantity: '1kg',
      price: 5,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Pamkin',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxlklvxcb%20dAsset%2011.png?alt=media&token=815b1690-bf1d-49f3-9716-b0a3be31dbe2',
      itemQuantity: '1kg',
      price: 10,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'carrots ',
      image:
          'https://firebasestorage.googleapis.com/v0/b/farmex-shop.appspot.com/o/Products%2Fffxxllklvxcb%20dAsset%2073.png?alt=media&token=b819001c-543f-4412-95c8-88bc7dd9b175',
      itemQuantity: '1kg',
      price: 65,
      theme: greenTheme),
];

var m = Map();

List<Product> carted = [];
List<Product> wishlisted = [];
List<Product> vegetables = [];
List<Product> fruits = [];
List<NotificationContent> userNotifications = [];
var inCart = {}; //payment calculation
int newNotifications = 1;
int itemCountInCart = 0;
ValueNotifier<int> itemCountInCartVn = ValueNotifier(0);
List<NotificationContent> preNotifications = [
  NotificationContent(
    title: 'Friday offer: 50% Off!!',
    description: RichText(
      text: TextSpan(
          text: """Farmex Shop\'s freshest supermarket offers an extensive 
                smile, shop Farmex Shop garden.""",
          style: TextStyle(color: Colors.grey)),
    ),
    image: 'assets/images/city.png',
  ),
  NotificationContent(
    title: 'Sunday offer: 30% Off!!',
    description: RichText(
      text: TextSpan(
          text: """Farmex Shop\'s freshest supermarket offers an extensive 
                smile, shop Farmex Shop garden.""",
          style: TextStyle(color: Colors.grey)),
    ),
    image: 'assets/images/city.png',
  ),
  NotificationContent(
    title: 'Saturday offer: 20% Off!!',
    description: RichText(
      text: TextSpan(
          text: """Farmex Shop\'s freshest supermarket offers an extensive 
                smile, shop Farmex Shop garden.""",
          style: TextStyle(color: Colors.grey)),
    ),
    image: 'assets/images/city.png',
  ),
  NotificationContent(
    title: 'Welcome to Farmex Shop',
    description: RichText(
      text: TextSpan(
          text: """Farmex Shop\'s freshest supermarket offers an extensive 
                range of groceries, a fabulous choice of fresh foods. 
                Farmex Shop is Bangladesh\'s cheapest full-service 
                supermarket. For self service or friendly 
                service where we pack your groceries with a 
                smile, shop Farmex Shop garden.""",
          style: TextStyle(color: Colors.grey)),
    ),
    image: 'assets/images/city.png',
  ),
];

class NotificationContent {
  NotificationContent({this.title, this.description, this.image});
  DateTime date = DateTime.now();
  String title;
  RichText description;
  String image;
}

class OrderModel {
  String id;
  String userId;
  String publicKey;
  String date;
  Map inCart;
  bool paied;
  int payable;
  OrderModel.fromQsnapshot(QueryDocumentSnapshot e, String key) {
    this.id = e.data()['id'];
    this.userId = e.data()['userId'];
    this.date = e.data()['date'];
    this.paied = e.data()['paied'];
    this.payable = e.data()['payable'];
    this.inCart = e.data()['items'];
    this.publicKey = key;
  }
}

class Order {
  Order(this.items, this.inCart, this.status);

  String id;
  String date = DateFormat.yMMMd().format(DateTime.now());
  List<Product> items;
  var inCart;
  String status;
  bool paied;
  int payable;
  int totalAmount() {
    int _toatal = 0;
    items.forEach((e) {
      _toatal += e.price * inCart[e.name];
    });
    return _toatal;
  }
}

List<Order> orders = [
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
