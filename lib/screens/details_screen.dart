import 'package:farmex_shop/controllers/productController.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/ui/ful_width_button.dart';
import 'package:farmex_shop/ui/gallery_card.dart';
import 'package:farmex_shop/ui/releted_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/constants.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({this.p, this.refreshParen});
  final Product p;
  final Function refreshParen;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List reletedItems;
  @override
  void initState() {
    super.initState();
    reletedItems = [];
    for (var item in preProducts) {
      if (widget.p.type == item.type &&
          !productController.carted.contains(item) &&
          !productController.wishlisted.contains(item) &&
          widget.p.name != item.name) reletedItems.add(item);
      if (reletedItems.length >= 2) break;
    }
    print('reletedItems: ${reletedItems.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CustomPaint(
                          painter: widget.p.theme['detail'],
                          child: Container(
                            height: 120,
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(children: [
                                  Positioned(
                                    top: -10,
                                    left: -10,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        size: 35,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                                //SizedBox(height: 20),
                                Container(
                                  height: 400,
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.05),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(0,
                                            -3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Icon(
                                            widget.p.loved
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 35,
                                            color: widget.p.loved
                                                ? kDeepGeen
                                                : Colors.grey.withOpacity(.3),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Hero(
                                          tag: widget.p.name,
                                          child: Image(
                                            height: 200,
                                            image: NetworkImage(widget.p.image),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 45, left: 20, right: 20),
                                        child: ListTile(
                                          isThreeLine: true,
                                          trailing: Text(
                                            '\$${widget.p.price}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black87
                                                  .withOpacity(.5),
                                            ),
                                          ),
                                          title: Text(
                                            widget.p.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(widget.p.itemQuantity),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        letterSpacing: 1),
                                    overflow: TextOverflow.clip,
                                    maxLines: 4,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, bottom: 5),
                                      child: Text(
                                        'Releted Items',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(children: [
                                      for (var item in reletedItems)
                                        ReletedItemCard(
                                          p: item,
                                        )
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 30),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'This is how ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Your ${widget.p.name} ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: widget.p.theme['deep'],
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'prepared on Farmex garden!!',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 150,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      galleryCard('assets/images/three.jpg'),
                                      galleryCard('assets/images/one.jpg'),
                                      galleryCard('assets/images/two.jpg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          FulWithButton(
            buttonHandle: () {
              if (!productController.carted.contains(widget.p)) {
                productController.carted.add(widget.p);
                productController.inCart[widget.p.name] = 1;
              }
              Navigator.pop(context);
              print('Item in cart: ${carted.length}');
              widget.refreshParen();
            },
            text: 'Add to Cart',
          ),
        ],
      ),
    );
  }
}

Widget fulWidthButton() {
  return Container(
    width: double.infinity,
    height: 50.0,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffA8DE1C), Color(0xff50AC02)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ]),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Text('Add to Card',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    ),
  );
}
