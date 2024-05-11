import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id_ChiTietDonHang'],
      name: json['dungCu']['tenDungCu'],
      quantity: json['soLuong'],
      price: json['donGia'].toDouble(),
      imageUrl: json['dungCu']['hinhAnh'],
    );
  }
}

class CartService {
  Future<List<CartItem>> getCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    final response = await http.get(Uri.parse(
        'https://nearby-capital-chipmunk.ngrok-free.app/api/cart/$uid'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi khi tải giỏ hàng');
    }
  }

  Future<double> getTotal() async {
    //lay uid tu sharedPreferences
    Future<String?> _getUserIdFromSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userId');
    }

    var uid = await _getUserIdFromSharedPreferences();
    final response = await http.get(Uri.parse(
        'https://nearby-capital-chipmunk.ngrok-free.app/api/cart/total/$uid'));
    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Lỗi khi tải giỏ hàng');
    }
  }
}
