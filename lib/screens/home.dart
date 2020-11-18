import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/models/products.dart';
import 'package:farmex_shop/ui/releted_item_card.dart';
import 'package:farmex_shop/ui/squared_card.dart';
import 'package:farmex_shop/ui/typed_card.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatelessWidget {
  HomeMain({Key key}) : super(key: key);
  final ProductClass pAll = ProductClass();
  final List<Product> products = ProductClass().getProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image(
                        width: 40,
                        image: AssetImage('assets/images/delivery.png'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Search products',
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(.5),
                            ),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  typeCard(Colors.lightGreen[100].withOpacity(.5),
                      'assets/images/broccoli.png', 'Vagetebles'),
                  typeCard(
                      Color(0x40FCD770), 'assets/images/fruit.png', 'Fruits'),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Color(0xffFC5455),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'NEW ARRAIVALS',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      'SEE ALL',
                      style: TextStyle(fontSize: 15, color: Color(0xffFC5455)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 15),
                  squaredCard(),
                  squaredCard(),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Color(0xff03506C),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'DAILY NEEDS',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      'SEE ALL',
                      style: TextStyle(fontSize: 15, color: Color(0xffFC5455)),
                    ),
                  ],
                ),
              ),
              ReletedItemCard(p: products[0]),
              ReletedItemCard(p: products[1]),
              ReletedItemCard(p: products[2]),
              ReletedItemCard(p: products[3]),
              // reletedItemCar(),
              // reletedItemCar(),
              // reletedItemCar(),
              // reletedItemCar(),
              // reletedItemCar(),
              // reletedItemCar(),
            ],
          ),
        ),
      ),
    );
  }
}
