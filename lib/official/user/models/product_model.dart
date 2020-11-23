import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/colors.dart';

enum types { vegetable, fruit, mortar }

class ProductModel {
  var type;
  String name;
  String image;
  String unit;
  String id;
  bool loved = false;
  int price = 0;
  int numOfItemSelected = 1;
  var theme;

  ProductModel({
    this.type,
    this.name,
    this.price,
    this.image,
    this.unit,
    this.theme,
  });

  ProductModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot p)
      : name = p.data()['producName'],
        image = p.data()['imageUrl'], //image in product model
        unit = p.data()['productUnit'],
        price = int.parse(p.data()['producPrice']),
        theme = p.data()['producTheme'] == 'green' ? greenTheme : orangeTheme,
        type = p.data()['producType'] == 'vegetable'
            ? types.vegetable
            : p.data()['producType'] == 'fruit'
                ? types.fruit
                : types.mortar;
}
