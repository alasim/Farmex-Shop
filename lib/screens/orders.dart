import 'package:badges/badges.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/notification_details.dart';
import 'package:farmex_shop/screens/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _newNotiHighliter(item) {
    var newNoti = orders.length - orders.indexOf(item) == newNotifications;
    return newNoti;
  }

  @override
  Widget build(BuildContext context) {
    print('orders.length: ${orders.length}');

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: appBarWithBackButton('Orders', context),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  for (var item in [...orders].reversed)
                    item.status == 'Paied'
                        ? Dismissible(
                            child: orderCard(item, context),
                            onDismissed: (direction) {
                              if (DismissDirection.startToEnd == direction) {}
                              if (DismissDirection.endToStart == direction) {}
                            },
                            key: UniqueKey(),
                            background: _deleteBg(),
                            secondaryBackground: _wishlistBg(),
                          )
                        : _newNotiHighliter(item)
                            ? newCard(item, orderCard(item, context))
                            : orderCard(item, context),
                  //SizedBox(height: MediaQuery.of(context).size.height - 450),
                ],
              ),
            ),
            orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.boxOpen,
                          size: 100,
                          color: kDeepGeen,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'No orders.',
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

Widget appBarWithBackButton(title, context) {
  return AppBar(
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
      title,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black87,
      ),
    ),
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    elevation: 0,
  );
}

Widget _deleteBg() {
  return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.red[200],
      alignment: Alignment.centerLeft,
      child: Icon(Icons.delete, color: Colors.white));
}

Widget _wishlistBg() {
  return Container(
    padding: EdgeInsets.only(right: 20),
    color: Colors.green[200],
    alignment: Alignment.centerRight,
    child: Icon(
      Icons.archive,
      color: Colors.white,
    ),
  );
}

Widget newCard(item, child) {
  return Badge(
    badgeContent: Text(
      'New',
      style: TextStyle(fontSize: 10, color: Colors.white),
    ),
    badgeColor: Colors.green,
    //shape: BadgeShape.square,
    child: child,
  );
}

Widget orderCard(item, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetails(item, item.totalAmount()),
        ),
      );
    },
    child: Card(
      color: Colors.grey[200],
      elevation: .2,
      child: ListTile(
        leading: Image(image: AssetImage('assets/images/icon.png'), width: 30),
        title: Text(item.date),
        subtitle: Text('${item.items[0].name}...'),
        trailing: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Total: \৳${item.totalAmount().toString()}\nStatus: ',
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: item.status,
                style: TextStyle(
                    color: item.status == 'Paied'
                        ? Colors.green
                        : Colors.red[300]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
