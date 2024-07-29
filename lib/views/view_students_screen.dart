import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';
import 'edit_student_screen.dart';
import '../models/student.dart';

class ViewStudentsScreen extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  ViewStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: Obx(() {
        if (studentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (studentController.students.isEmpty) {
          return  const Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: studentController.students.length,
            itemBuilder: (context, index) {
              final student = studentController.students[index];
              return ListTile(
                title: Text(student.name ?? ''),
                onTap: () {
                  _showStudentOptions(context, student);
                },
              );
            },
          );
        }
      }),
    );
  }

  void _showStudentOptions(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text('Lihat Data'),
              onTap: () {
                Get.back();
                _viewStudentDetails(context, student);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title:  const Text('Update Data'),
              onTap: () {
                Get.back();
                Get.to(() => EditStudentScreen(student: student));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Hapus Data'),
              onTap: () {
                Get.back();
                _confirmDelete(context, student);
              },
            ),
          ],
        );
      },
    );
  }

  void _viewStudentDetails(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detail Mahasiswa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Nomor: ${student.nomor}'),
              Text('Nama: ${student.name}'),
              Text('Tanggal Lahir: ${student.tanggalLahir}'),
              Text('Jenis Kelamin: ${student.jenisKelamin}'),
              Text('Alamat: ${student.alamat}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () {
                Get.back();
                studentController.deleteStudent(student.id!);
              },
            ),
          ],
        );
      },
    );
  }
}
