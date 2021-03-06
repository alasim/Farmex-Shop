import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/services/database.dart';
import 'package:farmex_shop/ui/item_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmex_shop/ui/item_main.dart';

class FireProductCOntroller extends GetxController {
  List<ItemMain> _allItems = [];

  Future<List<ItemMain>> itemsMain() async {
    var data = await Database().getProducts();
    data.forEach((p) {
      priceSet[p.name] = p.price;
      _allItems.add(ItemMain(
        p: p,
      ));
    });
    print('_allItems.length');
    print(_allItems.length);
    return _allItems;
  }
}
