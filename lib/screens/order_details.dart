import 'package:farmex_shop/models/datas.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails(this.order, this.totalAMount);
  final OrderModel order;
  final int totalAMount;
  @override
  Widget build(BuildContext context) {
    // String date = DateFormat.yMMMd().format(DateTime.now());
    // print('date');
    // print(date);
    // final now = new DateTime.now();
    // String formatter = DateFormat('yMd').format(now);
    // print('formatter');
    // print(formatter);
    // String time = DateFormat.jm().format(DateTime.now());
    // print('time');
    // print(time);
    //DateFormat.yMd().add_jm()
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 35,
              color: Colors.grey,
            ),
          ),
          title: Text(
            'Order details',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: RichText(
                    text: TextSpan(
                      text: 'Date: ${order.date}         \nStatus: ',
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                      children: [
                        TextSpan(
                          text: order.paied ? 'Paied' : 'Unpaied',
                          style: TextStyle(
                              color:
                                  order.paied ? Colors.green : Colors.red[300]),
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
                                        fontSize: 20, color: Color(0xff3c6382)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }

  Widget get rectBorderWidget {
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 2,
      child: Container(
        height: 200,
        width: 120,
        color: Colors.red,
      ),
    );
  }

  Widget get roundedRectBorderWidget {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 200,
          width: 120,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget get customBorder {
    Path customPath = Path()
      ..moveTo(-60, 0)
      ..lineTo(250, 0);

    return DottedBorder(
      customPath: (_) => customPath,
      color: Colors.indigo,
      dashPattern: [8, 4],
      strokeWidth: 2,
      child: Container(
        height: 220,
        width: 120,
        color: Colors.green.withAlpha(20),
      ),
    );
  }

  Widget get roundStrokeCap {
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(5),
      child: Container(
        height: 200,
        width: 120,
        color: Colors.red,
      ),
    );
  }

  Widget get solidBorder {
    return DottedBorder(
      dashPattern: [4, 3],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      child: Container(
        color: Colors.green,
        height: 200,
        width: 120,
      ),
    );
  }

  Widget get fullWidthPath {
    return DottedBorder(
      customPath: (size) {
        return Path()
          ..moveTo(0, 20)
          ..lineTo(size.width, 20);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(),
      ),
    );
  }
}
