import '../models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel model) => _userModel.value = model;

  void clear() {
    _userModel.value = UserModel();
  }
}

UserController userController = UserController();
