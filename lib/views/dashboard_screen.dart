import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_screen.dart';
import 'view_students_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(() => InputScreen());
              },
              child: const Text('Input Data Mahasiswa'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ViewStudentsScreen());
              },
              child: const Text('Lihat Data Mahasiswa'),
            ),
          ],
        ),
      ),
    );
  }
}
