import 'package:farmex_shop/official/user/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../services/database.dart';
import '../power_controllers/userController.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>();

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
  }

  User get user => _user.value;

  void createUser(String name, String email, String password) async {
    try {
      UserCredential _user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (await Database().createDatabase(
        name: name,
        email: email,
        uid: _user.user.uid,
      )) {
        userController.user = UserModel(
          name: name,
          email: email,
          uid: _user.user.uid,
        );
        //Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error from auth controller',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential _userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      assert(_userCred.user.uid != null);

      if (await Database().isDatabasePresent(_userCred.user.uid)) {
        //if already user have a database, get the data and set it
        DocumentSnapshot doc = await Database().getDatabase(_userCred.user.uid);
        if (doc != null) {
          userController.user = UserModel.fromDocumentSnashot(doc);
        }
      } else {
        // create database for this user and set it
        if (await Database().createDatabase(
          name: _userCred.user.displayName,
          email: _userCred.user.email,
          uid: _userCred.user.uid,
        )) {
          userController.user = UserModel(
            name: _userCred.user.displayName,
            email: _userCred.user.email,
            uid: _userCred.user.uid,
            photoURL: _userCred.user.photoURL,
          );
          //Get.back();
        }
      }

      print('_userCred.user.displayName');
      print(_userCred.user.displayName);
    } catch (e) {
      Get.snackbar(
        'Error from auth controller',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //signed? then should call database to get the user and set it
      if (_user.user.uid != null) {
        DocumentSnapshot doc = await Database().getDatabase(_user.user.uid);
        if (doc != null) {
          userController.user = UserModel.fromDocumentSnashot(doc);
        }
      }
      return _user;
    } catch (e) {
      Get.snackbar(
        'Error from auth controller',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}

AuthController authController = AuthController();
