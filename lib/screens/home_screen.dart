import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/search_screen.dart'; // Assuming this import is needed
import 'package:whiskflourish/screens/all_product_screen.dart'; // Assuming this import is needed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Whisk & Flourisk'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SearchBarApp(),
                    ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.message),
              tooltip: 'Go to the next page',
              onPressed: () {
                // Handle next page navigation (optional)
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tổng quan'), // First tab
              Tab(text: 'Tất cả'), // Second tab
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Nội dung Tổng quan')), // Content for first tab
            AllProductScreen(), // Content for second tab
          ],
        ),
      ),
    );
  }
}
