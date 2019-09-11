import 'package:flutter/material.dart';
import '../providers/orders.dart' as o;

class OrderItem extends StatelessWidget {

  final o.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${}'),
          )
        ],
      ),
     );
  }
}
