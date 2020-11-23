import 'package:farmex_shop/models/constants.dart';
import 'package:flutter/cupertino.dart';

class Product {
  Product(
      {this.type,
      this.name,
      this.price,
      this.image,
      this.itemQuantity,
      this.theme});
  var type, name, image, itemQuantity, theme;
  final int price;

  var id, loved = false, numOfItemSelected = 1;
}
