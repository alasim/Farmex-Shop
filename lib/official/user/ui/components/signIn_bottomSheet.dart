import 'package:farmex_shop/controllers/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInBottomSheet extends StatelessWidget {
  TextEditingController _emailController =
      TextEditingController(text: 'hasan@gmail.com');

  TextEditingController _passwordController =
      TextEditingController(text: '*******');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(15),
        height: Get.height * 0.42,
        width: Get.width,
        child: Column(
          children: [
            Text(
              'You need to login to continue',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            field('Email', _emailController),
            field('Password', _passwordController),
            SizedBox(height: 10),
            Container(
              width: Get.width * 0.7,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: FlatButton(
                        color: Colors.amber,
                        onPressed: () async {
                          UserCredential _user =
                              await authController.signInWithEmailPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (!_user.isNullOrBlank) {
                            Get.back();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          authController.createUser('Awesome Person',
                              _emailController.text, _passwordController.text);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(0),
            //   child: FlatButton(
            //     color: Colors.amber[500],
            //     onPressed: () async {
            //       UserCredential _user =
            //           await authController.signInWithEmailPassword(
            //         _emailController.text,
            //         _passwordController.text,
            //       );
            //       if (!_user.isNullOrBlank) {
            //         Get.back();
            //       }
            //     },
            //     child: Text(
            //       'Login',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       color: Colors.grey,
            //       height: 2,
            //       width: 80,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 30),
            //       child: Text('OR'),
            //     ),
            //     Container(
            //       color: Colors.grey,
            //       height: 2,
            //       width: 80,
            //     ),
            //   ],
            // ),
            // FlatButton(
            //   color: Colors.green,
            //   onPressed: () {
            //     authController.createUser('Awesome Person',
            //         _emailController.text, _passwordController.text);
            //   },
            //   child: Text('Register'),
            // ),

            // Container(
            //   width: Get.width * 0.7,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.all(10),
            //           child: FlatButton(
            //             color: Colors.redAccent,
            //             onPressed: () async {
            //               UserCredential _user =
            //                   await authController.signInWithGoogle();
            //               print('_user.user.uid');
            //               print(_user.user?.uid);
            //               if (_user.user.uid != null) {
            //                 Get.back();
            //               }
            //             },
            //             child: Text(
            //               'Google',
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.all(10),
            //           child: FlatButton(
            //             color: Colors.blue[900],
            //             onPressed: () {
            //               Get.snackbar('Unavailable',
            //                   'Right now, this feature is not aavailable, please use google loging instead.');
            //             },
            //             child: Text(
            //               'Facebook',
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget field(hinText, controller) {
  return Container(
    width: 300,
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        prefixIcon: Icon(Icons.lock),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white70,
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
