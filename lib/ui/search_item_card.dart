import 'package:farmex_shop/controllers/productController.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/screens/details_screen.dart';
import 'package:farmex_shop/shared/CircleButton.dart';
import 'package:flutter/material.dart';

class SearchItemCard extends StatefulWidget {
  SearchItemCard({this.p, this.refreshParent, this.titleStyle});
  final Product p;
  final RichText titleStyle;
  final Function refreshParent;

  @override
  _SearchItemCardState createState() => _SearchItemCardState();
}

class _SearchItemCardState extends State<SearchItemCard> {
  Function wishlistHandle() {
    setState(() {
      widget.p.loved = widget.p.loved ? false : true;
      if (widget.p.loved)
        wishlisted.add(widget.p);
      else
        wishlisted.remove(widget.p);

      print(wishlisted.length.toString());
      //print(setting['wishlisted'][0]);
    });
    return null;
  }

  Function cartHandle() {
    setState(() {
      print(productController.carted.length);
      if (!productController.carted.contains(widget.p)) {
        productController.carted.add(widget.p);
        productController.inCart[widget.p.name] = 1;
        print(productController.carted.length);
      } else {
        productController.inCart.remove(widget.p.name);
        productController.carted.remove(widget.p);
      }

      //print(setting['wishlisted'][0]);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              p: widget.p,
              //refreshParen: widget.refreshParent,
            ),
          ),
        );
      },
      child: Container(
        child: Card(
          elevation: 0,
          margin: EdgeInsets.only(bottom: 1),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                SizedBox(width: 5),
                Container(
                    width: 65,
                    child: Image(
                      image: AssetImage('assets/images/${widget.p.image}'),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        widget.titleStyle,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: '\৳ ${widget.p.price}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' /${widget.p.itemQuantity}',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.grey[400],
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
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          wishlistHandle();
                        },
                        child: Icon(
                          widget.p.loved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: widget.p.loved
                              ? kDeepGeen
                              : Colors.grey.withOpacity(.2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleButton(
                          productController.carted.contains(widget.p)
                              ? Icons.done
                              : Icons.add, () {
                        cartHandle();
                        //widget.refreshParent();
                      }, 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
