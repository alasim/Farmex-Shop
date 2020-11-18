import 'package:badges/badges.dart';
import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/notification_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _newNotiHighliter(item) {
    var newNoti = preNotifications.length - preNotifications.indexOf(item) ==
        newNotifications;
    return newNoti;
  }

  @override
  Widget build(BuildContext context) {
    print('preNotifications.length: ${preNotifications.length}');

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
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
          'Notifications',
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
                  for (var item in [...preNotifications].reversed)
                    Dismissible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetails(item),
                            ),
                          );
                        },
                        child: _newNotiHighliter(item)
                            ? newCard(item)
                            : oldCard(item),
                      ),
                      onDismissed: (direction) {
                        if (DismissDirection.startToEnd == direction) {}
                        if (DismissDirection.endToStart == direction) {}
                      },
                      key: UniqueKey(),
                      background: _deleteBg(),
                      secondaryBackground: _wishlistBg(),
                    ),
                  //SizedBox(height: MediaQuery.of(context).size.height - 450),
                ],
              ),
            ),
            preNotifications.isEmpty
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
                          'No notifications.',
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
      ));
}

Widget newCard(item) {
  return Badge(
    badgeContent: Text(
      'New',
      style: TextStyle(fontSize: 10, color: Colors.white),
    ),
    badgeColor: Colors.green,
    //shape: BadgeShape.square,
    child: oldCard(item),
  );
}

Widget oldCard(item) {
  return Card(
    color: Colors.grey[50],
    elevation: .2,
    child: ListTile(
      leading: Image(image: AssetImage('assets/images/icon.png'), width: 30),
      title: Text(item.title),
      subtitle:
          Text('${item.description.text.toPlainText().substring(0, 30)}...'),
      trailing: Text(
        DateFormat.MMMd().format(item.date),
        style: TextStyle(color: Colors.grey),
      ),
    ),
  );
}
