import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                return Column(
                  children: <Widget>[
                    Text('Hello, ${user.uid}'),
                    // Add more user profile info here
                  ],
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
