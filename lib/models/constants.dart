import 'package:flutter/material.dart';
import './CustomShapeClipper.dart';

//Colors
const kLiteGeen = Color(0xff4cd137);
const kDeepGeen1 = Color(0xff44bd32);
const kLiteGeen1 = Color(0xff92ff1B); //#4cd137
const kDeepGeen = Color(0xff92D61B); //Color(0xff3a9e00)
const kExtraDeepGeen = Color(0xff39B54A); //Color(0xff3a9e00)
const kLiteOrange = Color(0xffFCa500);
const kDeepOrange = Color(0xffFC9000);

final customPaintGreen = MyCustomPaint(
  kLiteGeen,
  kDeepGeen,
  Colors.black87.withOpacity(.02),
  Colors.black.withOpacity(.01),
);

final customPaintOrange = MyCustomPaint(
  kDeepOrange,
  kLiteOrange,
  Colors.black87.withOpacity(.02),
  Colors.black.withOpacity(.01),
);

final greenTheme = {
  'detail': customPaintGreen, //only need for details page constructor
  'lite': kLiteGeen,
  'deep': kDeepGeen,
};

final orangeTheme = {
  'detail': customPaintOrange, //only need for details page constructor
  'lite': kLiteOrange,
  'deep': kDeepOrange,
};

const FOOD_DATA = [
  {"name": "Burger", "brand": "Hawkers", "price": 2.99, "image": "burger.png"},
  {
    "name": "Cheese Dip",
    "brand": "Hawkers",
    "price": 4.99,
    "image": "cheese_dip.png"
  },
  {"name": "Cola", "brand": "Mcdonald", "price": 1.49, "image": "cola.png"},
  {"name": "Fries", "brand": "Mcdonald", "price": 2.99, "image": "fries.png"},
  {
    "name": "Ice Cream",
    "brand": "Ben & Jerry's",
    "price": 9.49,
    "image": "ice_cream.png"
  },
  {
    "name": "Noodles",
    "brand": "Hawkers",
    "price": 4.49,
    "image": "noodles.png"
  },
  {"name": "Pizza", "brand": "Dominos", "price": 17.99, "image": "pizza.png"},
  {
    "name": "Sandwich",
    "brand": "Hawkers",
    "price": 2.99,
    "image": "sandwich.png"
  },
  {"name": "Wrap", "brand": "Subway", "price": 6.99, "image": "wrap.png"}
];
