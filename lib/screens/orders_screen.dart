import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {

  static const String routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length, 
        itemBuilder: (BuildContext context, int index) {
          return OrderItem(ordersData.orders[index]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}