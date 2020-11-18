import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/ui/releted_item_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WishlistMain extends StatefulWidget {
  WishlistMain(this.refreshParent);
  final Function refreshParent;

  @override
  _WishlistMainState createState() => _WishlistMainState();
}

class _WishlistMainState extends State<WishlistMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          'Your Wishlist',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  for (var item in wishlisted)
                    Dismissible(
                      child: ReletedItemCard(
                        p: item,
                        refreshParent: widget.refreshParent,
                      ),
                      onDismissed: (direction) {
                        if (DismissDirection.startToEnd == direction) {
                          wishlisted.remove(item);
                          preProducts.remove(item);
                          item.loved = false;
                          preProducts.add(item);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 700),
                              content:
                                  Text('${item.name} deleted from wishlist'),
                            ),
                          );
                          setState(() {
                            print('Wislisted: ${wishlisted.length}');
                          });
                          print('Deleted from wishlisted!');
                        }
                        if (DismissDirection.endToStart == direction) {
                          if (!carted.contains(item)) {
                            carted.add(item);
                            inCart[item.name] = 1;
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(milliseconds: 700),
                                content: Text('${item.name} added to cart'),
                              ),
                            );
                          }

                          print('Moved to carted!');
                          print(carted.length.toString());

                          //wishlisted.remove(item);

                        }
                      },
                      key: UniqueKey(),
                      background: _deleteBg(),
                      secondaryBackground: _wishlistBg(),
                    ),
                  //SizedBox(height: MediaQuery.of(context).size.height - 450),
                ],
              ),
            ),
            wishlisted.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/wishlist.png',
                          width: 200,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'No items in wishlist.',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}

Widget _deleteBg() {
  return Container(
    padding: EdgeInsets.only(left: 20),
    color: Colors.red,
    alignment: Alignment.centerLeft,
    child: Text(
      'DELETE \nFROM \nWISHLIST',
      style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 3),
    ),
  );
}

Widget _wishlistBg() {
  return Container(
    padding: EdgeInsets.only(right: 20),
    color: kDeepGeen,
    alignment: Alignment.centerRight,
    child: Text(
      'ADD TO CART',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    //Icon(
    //   Icons.favorite,
    //   color: Colors.white,
    //   size: 40,
    // ),
  );
}
