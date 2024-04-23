import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  // This is just a sample data. Replace this with your actual cart data.
  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Product 1', 'quantity': 2, 'price': 10.0},
    {'name': 'Product 2', 'quantity': 1, 'price': 20.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
    {'name': 'Product 3', 'quantity': 3, 'price': 15.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        backgroundColor: const Color(0xfff8d9d6),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(child: Text('A')),
                        title: Text(cartItems[index]['name']),
                        subtitle:
                            Text('Quantity: ${cartItems[index]['quantity']}'),
                        trailing: Text('\$${cartItems[index]['price']}'),
                        isThreeLine: true,
                      ),
                      const Divider(
                        height: 0,
                      ),
                    ],
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng tiền: ',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the payment process here
                  },
                  child: const Text('Thanh toán'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
