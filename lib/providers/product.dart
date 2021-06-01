import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

void _setFavValue(bool newValue){
  isFavourite = newValue;
  notifyListeners();
}

Future<void> toggleFavourite(String userId, String authToken) async{
  final oldStatus = isFavourite;
  isFavourite = !isFavourite;
  notifyListeners();

  final url = 'https://shop-app-56408-default-rtdb.firebaseio.com/userFavourite/$userId/$id.json?auth=$authToken';
  try{
   final res = await http.put(url, body: json.encode(isFavourite));
   if(res.statusCode >= 400) _setFavValue(oldStatus);
  }catch(e){
    _setFavValue(oldStatus);
  }
}
}
