import 'package:farmex_shop/screens/cart.dart';
import 'package:farmex_shop/screens/home_screen2.dart';
import 'package:farmex_shop/screens/wishlist.dart';
import 'package:farmex_shop/screens/you.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:farmex_shop/models/datas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'Farmex Shop',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Function refreshMain;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('orders: ${orders.length}');
  }

  @override
  Widget build(BuildContext context) {
    //itemCountInCart.
    return Scaffold(
      drawer: Drawer(child: DrawerHeader(child: Text('Home'))),
      body: Center(
        child: [
          // 4 screens go here...
          MyHomePage(() {
            setState(() {
              print('MyHomePage');
            });
          }), //need refresh on changing item on cart
          CartMain(() {
            setState(() {});
          }),
          WishlistMain(() {
            setState(() {
              print('WishlistMain');
            });
          }),
          YouOptionsScreen(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Badge(
              animationType: BadgeAnimationType.scale,
              badgeColor: Color(0xff92D61B),
              badgeContent: Text(
                carted.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('You'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff92D61B),
        onTap: _onItemTapped,
      ),
    );
  }
}