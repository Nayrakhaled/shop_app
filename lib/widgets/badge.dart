import 'package:flutter/material.dart';

class Badge extends StatelessWidget {

  final Widget child;
  final String value;
  final Color color;

  const Badge({@required this.value, this.color, @required this.child});


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(right: 8, top: 8, child: Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color != null? color: Theme.of(context).accentColor
          ),
          constraints: BoxConstraints(minHeight: 16, minWidth: 16),
          child: Text(value, style:  TextStyle(fontSize: 10 ), textAlign: TextAlign.center,),
        )),
      ],
    );
  }
}
