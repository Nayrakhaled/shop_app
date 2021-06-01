import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: Center(
      ),
      drawer: AppDrawer(),
    );
  }
}
