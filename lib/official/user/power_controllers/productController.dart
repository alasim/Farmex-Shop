import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/database.dart';

class ProductController extends GetxController {
  //obserbable datas
  //confused to make it obseralble...
  RxList<ProductModel> allProducts = RxList<ProductModel>();
  RxList<ProductModel> wishlisted = RxList<ProductModel>();
  RxList<ProductModel> carted = RxList<ProductModel>();
  RxMap<String, int> priceSet = {}.obs;
  RxMap<String, int> inCart = {}.obs;
  //product name ind it's price will be present here
  //map for nmae with price, like {mango:3,apple:2}

  //regualr datas
  List<ProductModel> vegetables = List<ProductModel>();
  List<ProductModel> fruits = List<ProductModel>();

  @override
  void onInit() {
    allProducts.bindStream(Database().getProductList());
    allProducts.listen((productsList) {
      productsList.forEach((element) {
        priceSet[element.name] = element.price;
      });
      print('priceSet from producController');
      print(priceSet);
    });
  }
}

ProductController productController = ProductController();
// class TodoController extends GetxController {
//   Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

//   List<TodoModel> get todos => todoList.value;

//   @override
//   void onInit() {
//     String uid = Get.find<AuthController>().user.uid;
//     todoList
//         .bindStream(Database().todoStream(uid)); //stream coming from firebase
//   }
// }
