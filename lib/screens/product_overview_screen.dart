import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/widgets/app_drawer.dart';
class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
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
