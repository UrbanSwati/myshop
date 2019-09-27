import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: FutureBuilder( 
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An Error occuried!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderItem(ordersData.orders[index]);
                  },
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
