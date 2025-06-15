import 'package:hive_flutter/hive_flutter.dart';

class HiveChat {
  void insertData({required String name, required String message, required String time}) async {
    var box = Hive.box("chat");
    Map<String, dynamic> data = {'id': 1, "name": name, "message": message, "time": time};
    await box.add(data);
  }

   List<Map<String, dynamic>> readAlldata() {
     List<Map<String, dynamic>> localProducts = [];
    var box =  Hive.box("chat");
    for (var i = 0; i < box.length; i++) {
      final product = box.getAt(i);
      if (product != null && product is Map<String, dynamic>) {
        localProducts.add(product);
      }
      print(product);
    }
    return localProducts;
  }
}
