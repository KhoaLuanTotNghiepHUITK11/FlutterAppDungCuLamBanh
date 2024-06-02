import 'package:flutter/material.dart';
import 'package:whiskflourish/services/product_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class MainScreenScreen extends StatefulWidget {
  const MainScreenScreen({super.key});

  @override
  State<MainScreenScreen> createState() => _MainScreenScreenState();
}

class _MainScreenScreenState extends State<MainScreenScreen> {
  //Goi Service de lay danh sach san pham
  final ProductService productService = ProductService();
  late Future<List<Product>> futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts = productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final int count = screenWidth ~/ 150;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          futureProducts = productService.getProducts();
        });
      },
      child: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: SizedBox(
                        width: 200,
                        height: 200, // Fixed height for the card
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/Pink%20and%20Brown%20Cute%20Opening%20Soon%20Banner.gif?alt=media&token=67a067f5-7ba9-4240-a4bc-8049db56ab5a',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Khuyến mại dành cho bạn',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
                          final url =
                              'http://34.150.89.227/Product/Detail/${product.id}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          elevation: 0,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    product.image,
                                    width: double
                                        .infinity, // Fixed height for the image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Padding(
                                  //padding==0

                                  padding:
                                      const EdgeInsets.fromLTRB(10, 3, 10, 0),

                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: Text(
                                    "${product.price}₫",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE91E63),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
