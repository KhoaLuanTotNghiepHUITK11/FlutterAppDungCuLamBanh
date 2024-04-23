import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Giỏ hàng'),
          backgroundColor: const Color(0xfff8d9d6),
        ),
        body: Text("Giỏ hàng"));
  }
}
