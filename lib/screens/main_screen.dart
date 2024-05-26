import 'package:flutter/material.dart';
import 'package:whiskflourish/services/product_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final int count = screenWidth ~/ 200;

    return FutureBuilder<List<Product>>(
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
                    child: Container(
                      width: double.infinity,
                      height: 150, // Adjust height as needed
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'http://35.223.233.219/logo/Designer.jpeg'),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = snapshot.data![index];
                    return GestureDetector(
                      onTap: () async {
                        final url =
                            'http://35.223.233.219/Product/Detail/${product.id}';
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  product.image,
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${product.price} VND",
                                  style: const TextStyle(fontSize: 16),
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
    );
  }
}
