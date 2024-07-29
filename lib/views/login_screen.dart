import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await DBHelper().getUser(
                  _usernameController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  Get.to(() => const DashboardScreen());
                } else {
                  Get.snackbar('Error', 'Invalid username or password');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
