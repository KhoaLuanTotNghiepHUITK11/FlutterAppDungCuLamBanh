import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ'), actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'logout') {
              // Handle logout here
            }
          },
          itemBuilder: (BuildContext context) {
            return {'logout', 'settings'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice == 'logout' ? 'Đăng xuất' : 'Cài đặt'),
              );
            }).toList();
          },
        ),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
