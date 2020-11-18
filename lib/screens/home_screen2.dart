import 'package:badges/badges.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/notifications.dart';
import 'package:farmex_shop/screens/search_page.dart';
import 'package:farmex_shop/ui/categoty_card.dart';
import 'package:farmex_shop/ui/item_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.refreshMain);
  final Function refreshMain;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoriesScroller categoriesScroller;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];
  List<Widget> allItems = [];
  List<Widget> vegetables = [];
  List<Widget> fruits = [];
  List<Widget> mortars = [];
  void getPostsData() {
    preProducts.forEach((e) {
      allItems.add(ItemMain(
        p: e,
        refreshMain: widget.refreshMain,
      ));
      if (e.type == types.vegetable) {
        vegetables.add(ItemMain(
          p: e,
          refreshMain: widget.refreshMain,
        ));
      } else if (e.type == types.fruit) {
        fruits.add(ItemMain(
          p: e,
          refreshMain: widget.refreshMain,
        ));
      } else if (e.type == types.mortar) {
        mortars.add(ItemMain(
          p: e,
          refreshMain: widget.refreshMain,
        ));
      }
    });
    setState(() {
      itemsData = allItems;
    });
  }

  @override
  void initState() {
    super.initState();
    categoriesScroller = CategoriesScroller(
      () {
        allCat();
      },
      () {
        vegCat();
      },
      () {
        fruitsCat();
      },
      () {
        mortarCat();
      },
      () {
        allCat();
      },
    );
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 80;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  void allCat() {
    print('all');
    setState(() {
      itemsData = allItems;
      print(allItems.length.toString());
    });
  }

  void vegCat() {
    setState(() {
      itemsData = vegetables;
      print(vegetables.length.toString());
    });
  }

  void fruitsCat() {
    setState(() {
      itemsData = fruits;
      print(fruits.length.toString());
    });
  }

  void mortarCat() {
    setState(() {
      itemsData = mortars;
      print(fruits.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.20;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Container(
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
                      padding:
                          const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                      child: Image.asset('assets/images/logo_small.png',
                          width: 120),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: kDeepGeen,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation,
                                        Widget child) {
                                      animation = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeIn);
                                      return ScaleTransition(
                                        scale: animation,
                                        alignment: Alignment.bottomCenter,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation) {
                                      return Searchpage();
                                    }),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: IconButton(
                              icon: newNotifications != 0
                                  ? Badge(
                                      animationType: BadgeAnimationType.scale,
                                      badgeContent: Text(
                                        newNotifications.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: kDeepGeen,
                                        size: 30,
                                      ),
                                    )
                                  : Icon(
                                      Icons.notifications,
                                      color: kDeepGeen,
                                      //size: 35,
                                    ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Notifications();
                                    },
                                  ),
                                );
                                setState(() {
                                  //newNotifications = 0;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
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
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  CategoriesScroller(
      this.all, this.vegetables, this.fruits, this.mortar, this.most);
  final Function all;
  final Function vegetables;
  final Function fruits;
  final Function mortar;
  final Function most;
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
                  onTapHandle: () {
                    all();
                  },
                  categoryHeight: categoryHeight),
              CategoryCard(
                image: 'broccoli.png',
                text: 'Vegetables',
                onTapHandle: () {
                  vegetables();
                },
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'fruit.png',
                text: 'Fruits',
                onTapHandle: () {
                  fruits();
                },
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'mortar.png',
                text: 'Mortar',
                onTapHandle: () {
                  mortar();
                },
                categoryHeight: categoryHeight,
              ),
              CategoryCard(
                image: 'most_wanted.jpg',
                text: 'Most Wanted',
                onTapHandle: () {
                  most();
                },
                categoryHeight: categoryHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
