import 'package:flutter/material.dart';
import 'package:whiskflourish/services/detail_product_service.dart';
import 'package:whiskflourish/services/product_service.dart';

class DetailScreen extends StatefulWidget {
final DetailProductService productService;
final Product product;
const DetailScreen({super.key, required this.productService, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<ProductDetail> futureProductDetail;

  @override
  void initState() {
    super.initState();
    futureProductDetail = widget.productService.getProductDetail(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<ProductDetail>(
            future: futureProductDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ProductDetail product = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius to change how rounded the corners are
                      child: Image.network(product.imageUrl),
                    ),
                    Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(product.price.round().toString()+'₫', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red)),
                    Text(product.category, style: const TextStyle(fontSize: 16)),
                    Text(product.moreInfo, style: const TextStyle(fontSize: 16)),
                    //add line 
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    //add button 'Add to cart'
                    ElevatedButton(
                      onPressed: () {
                      // Add product to cart
                      },
                      child: const Text(
                      'Thêm vào giỏ hàng',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // add select quantity
                    // const SizedBox(height: 10),
                    // Row(
                    //   children: <Widget>[
                    //     const Text('Quantity: '),
                    //     DropdownButton<int>(
                    //       value: 1,
                    //       items: List<int>.generate(product.quantity, (i) => i + 1).map((int value) {
                    //         return DropdownMenuItem<int>(
                    //           value: value,
                    //           child: Text(value.toString()),
                    //         );
                    //       }).toList(),
                    //       onChanged: (int? value) {
                    //         // Update quantity
                    //       },
                    //     ),
                    //   ],
                    // ),
                    //add line
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    //Share to facebook
                    ElevatedButton(
                      onPressed: () {
                      // Share to facebook
                      },
                      child: const Text(
                      'Chia sẻ lên Facebook',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //share to instagram
                    ElevatedButton(
                      onPressed: () {
                      // Share to instagram
                      },
                      child: const Text(
                      'Chia sẻ lên Instagram',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //tao khoang trong
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                      'Chi tiết sản phẩm',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //add description
                    Text(product.description, style: const TextStyle(fontSize: 16)),

                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}