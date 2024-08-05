import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

class EditStudentScreen extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final Student student;

  EditStudentScreen({super.key, required this.student});

  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nomorController.text = student.nomor ?? '';
    _nameController.text = student.name ?? '';
    _tanggalLahirController.text = studentController.formatDateForDisplay(student.tanggalLahir) ?? '';
    _jenisKelaminController.text = student.jenisKelamin ?? '';
    _alamatController.text = student.alamat ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Update Data')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomorController,
              decoration: const InputDecoration(labelText: 'Nomor'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tanggalLahirController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Lahir',
                hintText: 'DD-MM-YYYY',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                  _tanggalLahirController.text = formattedDate;
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _jenisKelaminController,
              decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                studentController.updateStudent(
                  Student(
                    id: student.id,
                    nomor: _nomorController.text,
                    name: _nameController.text,
                    tanggalLahir: _tanggalLahirController.text,
                    jenisKelamin: _jenisKelaminController.text,
                    alamat: _alamatController.text,
                  ),
                );
                Get.back();
              },
              child: const Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
