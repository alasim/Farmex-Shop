import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';

class ProductClass {
  List<Product> home = preProducts;
  List<Product> carted;
  List<Product> wishlisted;

  List<Product> getProducts() {
    return preProducts;
  }

  List<Product> getVegetable() {
    List<Product> temp;
    preProducts.forEach((element) {
      if (element.type == 'vegetable') temp.add(element);
    });
    return temp;
  }

  List<Product> getFruits() {
    List<Product> temp;
    preProducts.forEach((element) {
      if (element.type == 'fruit') temp.add(element);
    });
    return temp;
  }
}
