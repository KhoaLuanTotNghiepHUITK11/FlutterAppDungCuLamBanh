import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whiskflourish/screens/about_screen.dart';
import 'package:whiskflourish/screens/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  // Lấy thông tin phiên đăng nhập

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async => {
              if (value == 'about')
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  ),
                }
              else if (value == 'sign_out')
                {
                  // Đăng xuất
                  await FirebaseAuth.instance.signOut(),
                  // Xóa thông tin phiên đăng nhập

                  // Gọi hàm clearSession
                  await clearSession(),

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  ),
                }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'about',
                  child: Text('Giới thiệu'),
                ),
                const PopupMenuItem(
                  value: 'sign_out',
                  child: Text('Đăng xuất'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User? user = snapshot.data;
              if (user == null) {
                // User not logged in, show login button
                return ElevatedButton(
                  child: const Text('Đăng nhập'),
                  onPressed: () {
                    // Navigate to login screen
                  },
                );
              } else {
                // User logged in, show user profile
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Xin chào, ${user.displayName ?? 'Người dùng'}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email: ${user.email ?? 'Không có email'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Số điện thoại: ${user.phoneNumber ?? 'Không có số điện thoại'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Địa chỉ: ${user.phoneNumber ?? 'Không có địa chỉ'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Điểm thưởng: ${user.phoneNumber ?? 0}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          const url = 'http://35.223.233.219/Account/Edit';
                          // ignore: deprecated_member_use
                          if (await canLaunch(url)) {
                            // ignore: deprecated_member_use
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                          // Handle the payment process here
                        },
                        child: const Text('Cập nhật thông tin'),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        'Lịch sử đơn hàng',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Add order history list here
                      // Example static data, you should replace with real data
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            5, // Replace with the actual number of orders
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Đơn hàng #${index + 1}'),
                            subtitle: Text('Chi tiết đơn hàng...'),
                            onTap: () {
                              // Navigate to order details
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }
            // Show loading while connection state is not active
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
