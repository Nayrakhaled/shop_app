import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text('\$${order.amount}'),
        subtitle: Text(DateFormat('dd/MM/yyy hh:mm').format(order.dateTime)),
        children: order.products.map((product) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(product.title , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text('${product.quantity}x \$${product.price}' , style: TextStyle(fontSize: 18, color:Colors.grey),),
          ],
        )).toList(),
      ),
    );
  }
}
