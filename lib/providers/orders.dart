import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final String baseUrl = environment['baseApiUrl'];
    final url = '$baseUrl/orders.json?auth=$authToken';
    final List<OrderItem> loadedOrders = [];

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          id: orderId,
          products: (orderData['products'] as List<dynamic>).map((p) {
            return CartItem(
                title: p['title'],
                id: p['id'],
                price: p['price'],
                quantity: p['quantity']); 
          }).toList(),
        ));
      }); 

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final String baseUrl = environment['baseApiUrl'];
    final url = '$baseUrl/orders.json?auth=$authToken';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'products': cartProducts
                .map(
                  (cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  },
                )
                .toList(),
            'dateTime': timeStamp.toIso8601String()
          },
        ),
      );
      if (response.statusCode <= 400) {
        _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp,
          ),
        );
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
