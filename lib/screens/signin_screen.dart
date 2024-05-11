import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whiskflourish/widget/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Đăng nhập'),
          backgroundColor: const Color(0xfff8d9d6),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //Chuyen ve home
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (context) => const NavBarWidget(),
                ),
              );
            },
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Chào mừng đến WhiskFlourish',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật khẩu',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // Fluttertoast.showToast(msg: "Đăng nhập thành công");
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (context) => const NavBarWidget(),
                      ),
                    );
                    // Lưu thông tin phiên đăng nhập
                    Future<void> saveSession(String userId) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userId', userId);
                    }
                    saveSession(auth.currentUser!.uid);

                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Lỗi'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    // ignore: use_build_context_synchronously
                  }
                  // Add your sign-in logic here
                },
                child: const Text('Đăng nhập'),
              ),
              const Text("Chưa có tài khoản?"),
              TextButton(
                onPressed: () {
                  // Navigate to sign-up screen
                },
                child: const Text('Đăng ký ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
