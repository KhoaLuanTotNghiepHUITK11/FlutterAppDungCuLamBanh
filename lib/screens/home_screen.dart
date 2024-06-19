
import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/main_screen.dart';
import 'package:whiskflourish/screens/search_screen.dart'; // Assuming this import is needed
import 'package:whiskflourish/screens/all_product_screen.dart'; // Assuming this import is needed

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // final webViewController = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setBackgroundColor(const Color(0x00000000))
  //   ..setNavigationDelegate(
  //     NavigationDelegate(
  //       onProgress: (int progress) {
  //         // Update loading bar.
  //       },
  //       onPageStarted: (String url) {},
  //       onPageFinished: (String url) {},
  //       onHttpError: (HttpResponseError error) {},
  //       onWebResourceError: (WebResourceError error) {},
  //       onNavigationRequest: (NavigationRequest request) async {
  //         if (request.url.startsWith('http://35.223.233.219/')) {
  //           return NavigationDecision.prevent;
  //         } else {
  //           await launchUrl(
  //               request.url as Uri); // Assuming this function is defined
  //           return NavigationDecision.navigate;
  //         }
  //       },
  //     ),
  //   )
  //   ..loadRequest(Uri.parse('http://35.223.233.219/'));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logodoc.png',
            height: 30,
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
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
          children: <Widget>[
            // WebViewWidget(
            //   controller: webViewController,
            // ),

            // Content for first tab
            MainScreenScreen(),
            AllProductScreen(), // Content for second tab
          ],
        ),
      ),
    );
  }
}
