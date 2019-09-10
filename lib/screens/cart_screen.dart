import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/card_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('Place order'),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (BuildContext context, int index) {
                var item = cart.items.values.toList()[index];
                String productIdKey = cart.items.keys.toList()[index];
                
                return CardItem(item.id, productIdKey, item.price, item.quantity, item.title);
              },
            ),
          )
        ],
      ),
    );
  }
}
