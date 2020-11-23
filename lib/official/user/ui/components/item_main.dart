import 'dart:io';

import '../../power_controllers/productController.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/screens/details_screen.dart';
import 'package:farmex_shop/shared/CircleButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';

class ItemMain extends StatefulWidget {
  ItemMain({@required this.p, this.refreshMain, this.fileImahe});
  final ProductModel p;
  final Function refreshMain;
  final File fileImahe;
  @override
  _ItemMainState createState() => _ItemMainState();
}

class _ItemMainState extends State<ItemMain> {
  @override
  Widget build(BuildContext context) {
    Function wishlistHandle() {
      setState(() {
        widget.p.loved = widget.p.loved ? false : true;
        if (widget.p.loved)
          productController.wishlisted.add(widget.p);
        else
          productController.wishlisted.remove(widget.p);
      });
      return null;
    }

    cartHandle() {
      if (!productController.carted.contains(widget.p)) {
        productController.carted.add(widget.p);
        productController.inCart[widget.p.name] = 1;
      } else {
        productController.inCart.remove(widget.p.name);
        productController.carted.remove(widget.p);
      }
      print('productController.carted');
      print(productController.carted);
      print('productController.inCart[widget.p.name]');
      print(productController.inCart[widget.p.name]);
      //print(setting['wishlisted'][0]);
    }

    // Function cartHandle2() {
    //   setState(() {
    //     if (!carted.contains(widget.p)) {
    //       carted.add(widget.p);
    //       inCart[widget.p.name] = 1;
    //       // Scaffold.of(context).showSnackBar(
    //       //   SnackBar(
    //       //     duration: Duration(milliseconds: 700),
    //       //     content: Text('${widget.p.name} added to cart.'),
    //       //   ),
    //       // );
    //     } else {
    //       inCart.remove(widget.p.name);
    //       carted.remove(widget.p);
    //       Scaffold.of(context).showSnackBar(
    //         SnackBar(
    //           duration: Duration(milliseconds: 700),
    //           content: Text('${widget.p.name} removed from cart.'),
    //         ),
    //       );
    //     }
    //     print('${inCart[widget.p.name]}=1, inCart length = ${inCart.length}');
    //     print(carted.length.toString());
    //     //print(setting['wishlisted'][0]);
    //   });

    //   return null;
    // }

    Function itemClickHadle() {
      print(widget.p.name);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailsScreen(
      //       p: widget.p,
      //       //refreshParen: widget.refreshMain(),
      //     ),
      //   ),
      // );
      return null;
    }

    return Obx(() => Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 5.0),
              ]),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        itemClickHadle();
                      },
                      child: Text(
                        widget.p.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        CircleButton(
                          productController.carted.contains(widget.p)
                              ? Icons.done
                              : Icons.add,
                          () {
                            cartHandle();
                            // widget.refreshMain();
                            // itemCountInCartVn.value = carted.length;
                          },
                        ),
                        SizedBox(width: 15),
                        RichText(
                          text: TextSpan(
                            text: '\৳ ${widget.p.price}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: ' /${widget.p.unit}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Hero(
                          tag: DateTime.now().toString(),
                          child: GestureDetector(
                            onTap: () {
                              itemClickHadle();
                            },
                            child: widget.fileImahe.isNull
                                ? Image.network(
                                    widget.p.image,
                                    //height: 150,
                                    width: 80,
                                  )
                                : Image.file(
                                    widget.fileImahe,
                                    width: 80,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            wishlistHandle();
                          },
                          child: Icon(
                            widget.p.loved
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 27,
                            color: widget.p.loved
                                ? kDeepGeen.withOpacity(.7)
                                : Colors.grey.withOpacity(.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
