import 'package:farmex_shop/shared/CircleButton.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';

class ReletedItemCard extends StatefulWidget {
  ReletedItemCard({this.p, this.refreshParent});
  final Product p;
  final Function refreshParent;

  @override
  _ReletedItemCardState createState() => _ReletedItemCardState();
}

class _ReletedItemCardState extends State<ReletedItemCard> {
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
      if (!carted.contains(widget.p)) {
        carted.add(widget.p);
        inCart[widget.p.name] = 1;
        Scaffold.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text('${widget.p.name} added to cart'),
          ),
        );
      } else {
        inCart.remove(widget.p.name);
        carted.remove(widget.p);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text('${widget.p.name} deleted from cart'),
          ),
        );
      }
      print(carted.length.toString());
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
                        Text(
                          widget.p.name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
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
                          carted.contains(widget.p) ? Icons.done : Icons.add,
                          () {
                        cartHandle();
                        widget.refreshParent();
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
