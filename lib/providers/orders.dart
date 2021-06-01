import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/card.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;

  getData(String token, String userId, List<OrderItem> order) {
    authToken = authToken;
    userId = userId;
    _orders = order;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetProducts() async {
    var ur =
        'https://shop-app-56408-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final res = await http.get(ur);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData == null) return;

      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) =>
                CartItem(id: item['id'], title: item['title'], quantity: item['quantity'], price: item['price'],),)
                .toList(),
          ),
        );
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async{
    final url = 'https://shop-app-56408-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try{
      final timesamp = DateTime.now();
      final res = await http.post(url, body: json.encode({
        'amount': total,
        'dateTime': timesamp.toIso8601String(),
        'products': cartProduct.map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price
        }).toList(),
      }));

      _orders.insert(0, OrderItem(id: json.decode(res.body)['name'], amount: total, products: cartProduct, dateTime: timesamp));
      notifyListeners();
    }catch(e){
      throw e;
    }
  }
}
