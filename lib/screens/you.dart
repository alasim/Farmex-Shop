import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/screens/order_details.dart';
import 'package:farmex_shop/screens/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouOptionsScreen extends StatefulWidget {
  @override
  _YouOptionsScreenState createState() => _YouOptionsScreenState();
}

class _YouOptionsScreenState extends State<YouOptionsScreen> {
  int _selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('You'),
        backgroundColor: Colors.white,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 243, 243, 1),
          body: ListView(
            children: [
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(),
                        ),
                      );
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
                      color: Colors.grey[300],
                    ),
                    onPressed: null),
              ),
              ListTile(
                tileColor: Colors.white,
                leading: Image.asset(
                  'assets/images/card.png',
                  width: 30,
                ),
                title: Text(
                  'Payment details',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.grey[300],
                    ),
                    onPressed: null),
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
                      color: Colors.grey[300],
                    ),
                    onPressed: null),
              ),
              //SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:farmex_shop/models/CircleButton.dart';
// import 'package:farmex_shop/screens/cart.dart';
// import 'package:farmex_shop/ui/releted_item_card.dart';
// import 'package:flutter/material.dart';

// class YouMain extends StatelessWidget {
//   const YouMain({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 243, 243, 1),
//       appBar: AppBar(
//         title: Text(
//           'You',
//           style: TextStyle(
//             fontSize: 15,
//             color: Colors.black87,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         brightness: Brightness.light,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.list_alt,
//                       color: Color(0xff92D61B),
//                     ),
//                   ),
//                   Text(
//                     'My Orders',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.list_alt,
//                       color: Color(0xff92D61B),
//                     ),
//                   ),
//                   Text(
//                     'My Orders',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.list_alt,
//                       color: Color(0xff92D61B),
//                     ),
//                   ),
//                   Text(
//                     'My Orders',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.list_alt,
//                       color: Color(0xff92D61B),
//                     ),
//                   ),
//                   Text(
//                     'My Orders',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.list_alt,
//                       color: Color(0xff92D61B),
//                     ),
//                   ),
//                   Text(
//                     'My Orders',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
