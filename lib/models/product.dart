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
  final type, name, price, image, itemQuantity, theme;

  var id, loved = false, numOfItemSelected = 1;
}
