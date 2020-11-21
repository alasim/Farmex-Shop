import 'package:farmex_shop/controllers/authController.dart';
import 'package:farmex_shop/screens/adminPage.dart';
import 'package:farmex_shop/screens/order_confirmed.dart';
import 'package:farmex_shop/screens/orders.dart';
import 'package:farmex_shop/screens/wishlist.dart';
import 'package:farmex_shop/ui/signIn_bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/drawer_bg.png',
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54,
                          border: Border.all(width: 1, color: Colors.white)),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user (1).png'),
                              radius: 40,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Hasan Mahmud',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              fontFamily: 'Mitr',
                            ),
                          ),
                          Text(
                            'email.com',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.green[500]),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: IconButton(
                        icon: Icon(Icons.exit_to_app, color: Colors.green[500]),
                        onPressed: () {
                          if (authController.user == null) {
                            Get.back();
                            Get.bottomSheet(SignInBottomSheet());
                          } else {
                            authController.signOut();
                            Get.back();
                          }
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width,
                  color: Colors.green[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          label('504', Colors.green[600]),
                          label('14D', Colors.green[500]),
                          label('KAMINI 2', Colors.green[400]),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.share,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset(
                    'assets/images/history.png',
                    width: 30,
                  ),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(OrdersScreen());
                      }),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset(
                    'assets/images/star.png',
                    width: 30,
                  ),
                  title: Text(
                    'My favorite',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(WishlistMain());
                      }),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset(
                    'assets/images/card.png',
                    width: 30,
                  ),
                  title: Text(
                    'Payment details(login)',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                      ),
                      onPressed: () {}),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset(
                    'assets/images/settings.png',
                    width: 30,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                      ),
                      onPressed: () {
                        Get.back();
                        Get.to(AdminPage());
                      }),
                ),
                //SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
