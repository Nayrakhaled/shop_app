import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/card.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final int quantity;
  final double price;
  final String title;

  const CartItem(
    this.id,
    this.productId,
    this.quantity,
    this.price,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text('Do you want to remove item from the cart?'),
                actions: [
                  FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('No')),
                  FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes')),
                ],
                  ));
        },
        onDismissed: (direction){
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('\$$price'),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total \$${(price * quantity)}'),
              trailing: Text('$quantity x'),
            ),
          ),
        ));
  }
}
