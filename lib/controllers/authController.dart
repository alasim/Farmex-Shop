import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'dart:io';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('Users');
  Rx<User> _user = Rx<User>();
  var signup = true.obs;
  String get user => _auth.currentUser?.uid;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
  }

  Future<UserCredential> createUser(
      String name, String email, String password) async {
    UserCredential _user;
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (data) {
        _user = data;
        print(data.user.uid);
        _firestore.doc(data.user.uid).set({
          'name': name,
          'email': email,
        }).then((value) {
          print('New user data saved');
          return _user;
        }).catchError((err) {
          Get.snackbar('Error to save new user', err.message);
          return _user;
        });
      },
    ).catchError((err) {
      Get.snackbar('Error to creating user', err.message);
      return _user;
    });
    return _user;
  }

  Future<UserCredential> signInWithGoogle() async {
    UserCredential _user;
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    print('googleUser.id');
    print(googleUser.id);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print('googleAuth.idToken');
    print(googleAuth.idToken);

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('credential.idToken');
    print(credential.idToken);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then(
      (data) {
        _user = data;
        print('data.user.uid from authController');
        print(data.user.uid);
        _firestore.doc(data.user.uid).set({
          'name': 'Awesome Person',
        }).then((value) {
          print('New user data saved');
          return _user;
        }).catchError((err) {
          Get.snackbar('Error to save new user', err.message);
          return null;
        });
      },
    ).catchError((err) {
      Get.snackbar('Error to creating user', err.message);
      return null;
    });
    return null;
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    UserCredential _user;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (data) {
        _user = data;
        print(data.user.uid);
        return _user;
      },
    ).catchError((err) {
      Get.snackbar('Error to signIn', err.message);
      return _user;
    });
    return _user;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}

AuthController authController = AuthController();
