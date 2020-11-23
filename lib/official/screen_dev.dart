import 'package:farmex_shop/official/user/services/app_time.dart';
import 'package:farmex_shop/official/user/services/run.dart';
import 'package:flutter/material.dart';
import './user/ui/components/buttons.dart';
import 'package:get/get.dart';
import './user/ui/home_ui.dart';
import './user/power_controllers/userController.dart';

class ScreenDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(userController.user.name != null
                  ? userController.user.name
                  : 'No user')),
              FButton(
                text: 'User',
                color: Colors.green[700],
                onPressed: () {
                  Get.off(Home());
                },
              ),
              FButton(
                  text: 'Farmex Hero',
                  color: Colors.amber[700],
                  onPressed: () {}),
              FButton(
                text: 'Admin',
                color: Colors.redAccent,
                onPressed: () {},
              ),
              FButton(
                text: 'Run',
                color: Colors.greenAccent,
                onPressed: () {
                  run();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
