import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../power_controllers/authController.dart';
import '../services/database.dart';
import '../models/product_model.dart';

run() {
  print('run caleed');
  Database().getOrderList().listen((event) {
    event.forEach((element) {
      print(element.date);
    });
  });
}
