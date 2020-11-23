//import 'package:farmex_shop/controllers/fireProductController.dart';
//import 'package:farmex_shop/controllers/productController.dart';
import 'package:farmex_shop/screens/cart.dart';
import 'package:farmex_shop/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../power_controllers/productController.dart';
import '../ui/components/categoty_card.dart';
import '../ui/components/item_main.dart';
import '../ui/components/drawer.dart';
import '../constants/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoriesScroller categoriesScroller;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  void initState() {
    super.initState();
    categoriesScroller = CategoriesScroller();

    controller.addListener(() {
      double value = controller.offset / 80;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.20;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(CartMain());
          },
          backgroundColor: Colors.amber[400],
          icon: Icon(
            Icons.shopping_cart_outlined,
            size: 18,
            color: Colors.black54,
          ),
          label: Obx(() => Text(
                productController.carted.value.length.toString(),
                style: TextStyle(color: Colors.black45, fontSize: 18),
              )),
        ),
        appBar: AppBar(
          //leading: Container(color: Colors.white),
          iconTheme: IconThemeData(color: kDeepGeen, size: 20),
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                //stops: [.1, .3, .9],
                colors: [
                  kDeepGeen.withOpacity(.3),
                  Colors.white.withOpacity(.5),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 75, top: 10, bottom: 10),
                  child: Center(
                      child: Image.asset('assets/images/logo_small.png',
                          width: 120)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: kDeepGeen,
                          size: 20,
                        ),
                        onPressed: () {
                          Get.to(Searchpage());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 0,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : categoryHeight,
                  child: categoriesScroller,
                ),
              ),
              Expanded(
                  child: Obx(() => ListView.builder(
                        controller: controller,
                        itemCount: productController.allProducts.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          double scale = 1.0;
                          if (topContainer > 0.5) {
                            scale = index + 0.5 - topContainer;
                            if (scale < 0) {
                              scale = 0;
                            } else if (scale > 1) {
                              scale = 1;
                            }
                          }
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..scale(scale, scale),
                              alignment: Alignment.bottomCenter,
                              child: Align(
                                  heightFactor: 0.7,
                                  alignment: Alignment.topCenter,
                                  child: ItemMain(
                                      p: productController.allProducts[index])),
                            ),
                          );
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 100;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              CategoryCard(
                  image: 'fruits_and_vegetables.jpg',
                  text: 'All',
                  onTapHandle: () {},
                  categoryHeight: categoryHeight),
              CategoryCard(
                image: 'broccoli.png',
                text: 'Vegetables',
                onTapHandle: () {},
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'fruit.png',
                text: 'Fruits',
                onTapHandle: () {},
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'mortar.png',
                text: 'Mortar',
                onTapHandle: () {},
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'most_wanted.jpg',
                text: 'Most Wanted',
                onTapHandle: () {},
                categoryHeight: categoryHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
