import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  void addOrder(
      String name,
      String price,
      String image,
      String size,
      String paymentMethod,
      String deliveryMethod,
      String tableNumber,
      String address,
      String phoneNumber,
      ) {
    _orders.add({
      "name": name,
      "price": price,
      "image": image,
      "size": size,
      "paymentMethod": paymentMethod,
      "deliveryMethod": deliveryMethod,
      "tableNumber": tableNumber.isNotEmpty ? tableNumber : "N/A",
      "address": address.isNotEmpty ? address : "N/A",
      "phoneNumber": phoneNumber.isNotEmpty ? phoneNumber : "N/A",
      "status": "In Progress",
    });
    notifyListeners();
  }


  void updateOrderStatus(String name, String newStatus) {
    for (var order in _orders) {
      if (order["name"] == name) {
        order["status"] = newStatus;
        notifyListeners(); // Update UI
        break;
      }
    }
  }

  // ✅ NEW: Modify an existing order
  void modifyOrder(String name, String newSize, String newPayment) {
    for (var order in _orders) {
      if (order["name"] == name) {
        order["size"] = newSize;
        order["paymentMethod"] = newPayment;
        notifyListeners(); // Update UI
        break;
      }
    }
  }
}
