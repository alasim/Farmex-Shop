import 'package:dotted_border/dotted_border.dart';
import 'package:farmex_shop/controllers/adminController.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/ui/ful_width_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderDetails extends StatelessWidget {
  final OrderModel order;
  final int totalAMount;
  AdminOrderDetails(this.order, this.totalAMount);
  @override
  Widget build(BuildContext context) {
    print('ids to update');
    print('userId');
    print(order.userId);
    print('id');
    print(order.id);
    print('publicKey');
    print(order.publicKey);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      child: RichText(
                        text: TextSpan(
                          text: 'Date: ${order.date}         \nStatus: ',
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                          children: [
                            TextSpan(
                              text: order.paied ? 'Paied' : 'Unpaied',
                              style: TextStyle(
                                  color: order.paied
                                      ? Colors.green
                                      : Colors.red[300]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: DottedBorder(
                        padding: EdgeInsets.all(15),
                        dashPattern: [12, 4],
                        strokeWidth: 2.5,
                        color: Color(0xff3c6382),
                        child: Container(
                          height: 200 + (order.inCart.length).toDouble() * 20,
                          child: ListView(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    'BILL',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Table(children: [
                                for (var k in order.inCart.keys)
                                  TableRow(children: [
                                    Text('$k',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff3c6382))),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${priceSet[k]}x${order.inCart[k]}=${priceSet[k] * order.inCart[k]}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff3c6382)),
                                      ),
                                    ),
                                  ]),
                              ]),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '_ _ _ _ _ _ _ _',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff3c6382),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff3c6382),
                                    ),
                                  ),
                                  Text(
                                    '৳${totalAMount.toString()}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff3c6382),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          FulWithButton(() {
            adminController
                .makePaied(
                    userId: order.userId,
                    id: order.id,
                    publicKey: order.publicKey)
                .then((value) => Get.back());
          }),
        ],
      ),
    );
    ;
  }
}
