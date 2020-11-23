import 'package:farmex_shop/controllers/authController.dart';
import 'package:farmex_shop/main.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/adminOrders.dart';
import 'package:farmex_shop/screens/demo.dart';
import 'package:farmex_shop/screens/home_screen.dart';
import 'package:farmex_shop/screens/order_details.dart';
import 'package:farmex_shop/screens/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/productController.dart';

class OrderConfirmed extends StatefulWidget {
  @override
  _OrderConfirmedState createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {
  TextEditingController _addressController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  bool remember = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cash on Delivery')),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            Image.asset('assets/images/delivery-service.jpg',
                width: double.infinity),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Text(
                      'Delivery Address Details:',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  field(
                    labelText: 'Phone No',
                    hinText: 'Type Your Phone No here',
                    controller: _phoneController,
                  ),
                  field(
                    labelText: 'Address',
                    hinText: 'Type Delivery Address',
                    controller: _addressController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Remember:',
                        style: TextStyle(color: Colors.black38),
                      ),
                      Switch(
                        value: remember,
                        onChanged: (value) {
                          setState(() {
                            remember = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.amber,
                textColor: Colors.white,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Order order = Order(
                    List.from(productController.carted),
                    {...productController.inCart},
                    'Unpaied',
                  );
                  var map = {
                    'items': order.inCart,
                    'payable': order.totalAmount(),
                    'paied': false,
                    'date': order.date,
                    'userId': authController.user,
                    'timestamp': order.timestamp
                  };
                  print(map);
                  productController.addOrder(map);
                  print(productController.carted);
                  productController.carted.clear();
                  productController.inCart.clear();
                  Get.off(OrdersScreen());
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Get.snackbar('Order placed successfull',
                        'Order placed successfully, we are coming soon with your goods.');
                  });
                },
              ),
              SizedBox(width: 10),
              FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.grey[300],
                textColor: Colors.white,
                padding: EdgeInsets.all(10),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

Widget field({hinText, labelText, controller, width = 300, maxLine = 1}) {
  return Container(
    width: width.toDouble(),
    padding: EdgeInsets.all(10),
    child: TextField(
      minLines: 1, //Normal textInputField will be displayed
      maxLines: maxLine, // when user presses enter it will adapt to it
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white60,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
      ),
    ),
  );
}

Widget label(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
    ),
  );
}
