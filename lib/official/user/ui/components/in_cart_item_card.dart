import 'package:farmex_shop/shared/CircleButton.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InCartItemCard extends StatefulWidget {
  InCartItemCard(
      {this.p,
      this.quantity,
      this.addHandle,
      this.removeHandle,
      this.parentContext,
      this.refredhParent});
  final Product p;
  final int quantity;
  final Function addHandle;
  final Function removeHandle;
  final Function refredhParent;
  final BuildContext parentContext;
  @override
  _InCartItemCardState createState() => _InCartItemCardState();
}

class _InCartItemCardState extends State<InCartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
                    image: NetworkImage(widget.p.image),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: CircleButton(Icons.remove, () {
                      widget.removeHandle();
                      widget.refredhParent();
                    }, 23),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(widget.quantity.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleButton(Icons.add, () {
                      widget.addHandle();
                    }, 23),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        if (DismissDirection.startToEnd == direction) {
          if (!wishlisted.contains(widget.p)) {
            widget.p.loved = true;
            wishlisted.add(widget.p);
          }
          carted.remove(widget.p);

          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 700),
              content: Text('${widget.p.name} moved to wishlist'),
            ),
          );
          widget.refredhParent();
          print('to wishlisted!');
        }
        if (DismissDirection.endToStart == direction) {
          carted.remove(widget.p);

          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 700),
              content: Text('${widget.p.name} deleted from cart'),
            ),
          );
          widget.refredhParent();
          print('removed!');
        }
      },
      key: UniqueKey(),
      background: _wishlistBg(),
      secondaryBackground: _deleteBg(),
    );
  }
}

Widget _deleteBg() {
  return Container(
    padding: EdgeInsets.only(right: 20),
    color: Colors.red[200],
    alignment: Alignment.centerRight,
    child: Icon(
      Icons.delete,
      color: Colors.white,
      size: 40,
    ),
  );
}

Widget _wishlistBg() {
  return Container(
    padding: EdgeInsets.only(left: 20),
    color: kDeepGeen.withOpacity(.3),
    alignment: Alignment.centerLeft,
    child: Icon(
      Icons.favorite,
      color: Colors.white,
      size: 40,
    ),
  );
}
