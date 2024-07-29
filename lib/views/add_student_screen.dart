import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

class AddStudentScreen extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Data')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomorController,
              decoration: InputDecoration(labelText: 'Nomor'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: tanggalLahirController,
              decoration: InputDecoration(
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
                  tanggalLahirController.text = formattedDate;
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: jenisKelaminController,
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Student newStudent = Student(
                  nomor: nomorController.text,
                  name: nameController.text,
                  tanggalLahir: tanggalLahirController.text,
                  jenisKelamin: jenisKelaminController.text,
                  alamat: alamatController.text,
                );
                studentController.addStudent(newStudent);
                Get.back();
              },
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
