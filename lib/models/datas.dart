import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './product.dart';
import './constants.dart';

enum types { vegetable, fruit, mortar }
Map<String, int> priceSet = {}; //need for online persing
List<Product> preProducts = [
  Product(
      type: types.mortar,
      name: 'Capsicum',
      image: 'capsicum_red_yellow.png',
      itemQuantity: '1p',
      price: 5,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Cabbage',
      image: 'cabbage.png',
      itemQuantity: '1kg',
      price: 3,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Strawberry',
      image: 'strawberry.png',
      itemQuantity: '1kg',
      price: 30,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Mango',
      image: 'Image 30.png',
      itemQuantity: '1kg',
      price: 10,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Cucumber',
      image: 'cucumber.png',
      itemQuantity: '1kg',
      price: 6,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Orange',
      image: 'orange.png',
      itemQuantity: '1kg',
      price: 10,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Potato',
      image: 'potato.png',
      itemQuantity: '1kg',
      price: 4,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Tomato',
      image: 'tomato.png',
      itemQuantity: '1kg',
      price: 6,
      theme: orangeTheme),
  Product(
      type: types.fruit,
      name: 'Pineaple',
      image: 'pineaple.png',
      itemQuantity: '1p',
      price: 10,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Green Lemon',
      image: 'green_lemon.png',
      itemQuantity: '1p',
      price: 3,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Banana',
      image: 'banana.png',
      itemQuantity: '12p',
      price: 10,
      theme: greenTheme),
  Product(
      type: types.fruit,
      name: 'Guava',
      image: 'guava.png',
      itemQuantity: '4p',
      price: 7,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Red Chili',
      image: 'red_chili.png',
      itemQuantity: '1kg',
      price: 20,
      theme: orangeTheme),
  Product(
      type: types.vegetable,
      name: 'Green Broccoli',
      image: 'green_broccoli.png',
      itemQuantity: '1p',
      price: 7,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Salad Leaf',
      image: 'salad_leaf.png',
      itemQuantity: '1p',
      price: 3,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Cauliflower',
      image: 'cauliflower.png',
      itemQuantity: '1p',
      price: 6,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Green Pepper',
      image: 'green_pepper.png',
      itemQuantity: '1kg',
      price: 10,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Onion',
      image: 'onion.png',
      itemQuantity: '1kg',
      price: 5,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Ginger',
      image: 'ginger.jpg',
      itemQuantity: '1kg',
      price: 20,
      theme: greenTheme),
  Product(
      type: types.mortar,
      name: 'Garlic',
      image: 'Garlic.jpg',
      itemQuantity: '1kg',
      price: 30,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Lady Finger',
      image: 'Lady_Finger.jpg',
      itemQuantity: '1kg',
      price: 6,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Pamkin',
      image: 'pamkin.jpg',
      itemQuantity: '1p',
      price: 10,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'Celery',
      image: 'celery.jpg',
      itemQuantity: '12p',
      price: 5,
      theme: greenTheme),
  Product(
      type: types.vegetable,
      name: 'carrots ',
      image: 'carrots-vegetables.jpg',
      itemQuantity: '1kg',
      price: 7,
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
