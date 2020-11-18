import 'package:farmex_shop/main.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/screens/order_confirmed.dart';
import 'package:farmex_shop/screens/orders.dart';
import 'package:farmex_shop/ui/in_cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartMain extends StatefulWidget {
  CartMain(this.refreshParent);
  final Function refreshParent;

  @override
  _CartMainState createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  @override
  Widget build(BuildContext context) {
    int total = 0;
    setState(() {
      if (carted.isNotEmpty)
        for (var item in carted) total += item.price * inCart[item.name];
    });

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          'Your Cart',
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
              padding: const EdgeInsets.all(0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  //for (var item in carted) ReletedItemCard(item),
                  for (var item in carted)
                    InCartItemCard(
                      p: item,
                      quantity: inCart[item.name],
                      addHandle: () {
                        setState(() {
                          inCart[item.name]++;
                        });
                      },
                      removeHandle: () {
                        setState(
                          () {
                            inCart[item.name]--;
                            if (inCart[item.name] <= 0) {
                              carted.remove(item);
                              // Scaffold.of(context).showSnackBar(
                              //   SnackBar(
                              //     duration: Duration(milliseconds: 700),
                              //     content:
                              //         Text('${item.name} removed from cart.'),
                              //   ),
                              // );
                            }
                            print((MediaQuery.of(context).size.height - 370)
                                .toString());
                          },
                        );
                      },
                      parentContext: context,
                      refredhParent: () {
                        widget.refreshParent();
                        setState(() {
                          print('carted: ${carted.length.toString()}');
                        });
                      },
                    ),
                  SizedBox(height: 150),
                ],
              ),
            ),
            //SizedBox(height: 150),
            carted.isNotEmpty
                ? Positioned(
                    top: MediaQuery.of(context).size.height - 370,
                    child: ClipPath(
                      clipper: CartCliper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        color: Color(0xfffafafa),
                        child: CustomPaint(
                          painter: RoundPaint(),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 70),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal'),
                                      Text(
                                        '\৳$total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery Fee'),
                                      Text(
                                        '\৳0.0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          '\৳$total',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 100),
                                            transitionsBuilder: (BuildContext
                                                    context,
                                                Animation<double> animation,
                                                Animation<double> secAnimation,
                                                Widget child) {
                                              animation = CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.elasticInOut);
                                              return ScaleTransition(
                                                scale: animation,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: child,
                                              );
                                            },
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secAnimation) {
                                              return OrderConfirmed();
                                            }),
                                      );
                                      setState(() {
                                        orders.add(
                                          Order(List.from(carted), {...inCart},
                                              'Unpaied'),
                                        );
                                        carted.clear();
                                        inCart.clear();
                                      });
                                      widget.refreshParent();
                                      print(orders.toString());
                                      print('carted: ${carted.length}');
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 35),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffA8DE1C),
                                            Color(0xff92D61B)
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 17,
                                                  top: 13,
                                                  right: 13,
                                                  bottom: 13),
                                              child: Text(
                                                  'Continue to Checkout',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color: Colors.white54,
                                                      width: 0.5),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(13),
                                                child: Text(
                                                  '\৳$total',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/cart.png',
                          width: 200,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'No items in cart.',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CartCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 70);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 70);
    path.quadraticBezierTo(size.width / 2, 0, 0, 70);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RoundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(0, 75);
    path.quadraticBezierTo(size.width / 2 - 5, 0, size.width, 75);
    paint.color = kDeepGeen1;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
