import 'package:flutter/material.dart';
import '../models/student.dart';

class ShowStudentScreen extends StatelessWidget {
  final Student student;

  const ShowStudentScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nomor: ${student.nomor}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nama: ${student.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tanggal Lahir: ${student.tanggalLahir}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Jenis Kelamin: ${student.jenisKelamin}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Alamat: ${student.alamat}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}