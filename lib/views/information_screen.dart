import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Center(
        child: Padding(
              padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Aplikasi Kampusku merupakan aplikasi yang digunakan untuk pendataan mahasiswa. User nantinya bisa menambahkan, update dan hapus data mahasiswa.")
              ],
          ),
        ),
      ),
    );
  }
}
