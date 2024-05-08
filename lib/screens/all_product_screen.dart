import 'package:flutter/material.dart';
import 'package:whiskflourish/services/product_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
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
    final double screenWith = MediaQuery.of(context).size.width;
    final int count = screenWith ~/ 200;
    return FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () async {
                      final url =
                          'https://localhost:7249/Product/Detail/${product.id}';
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                      // Xử lý khi người dùng chọn sản phẩm
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
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(5, 10, 20, 10)),
                            Text(
                              "${product.price} VND",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
