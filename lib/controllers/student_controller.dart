import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../helpers/db_helper.dart';
import '../models/student.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  void fetchStudents() async {
    isLoading(true);
    try {
      var studentsFromDb = await DBHelper().getStudents();
      students.assignAll(studentsFromDb);
      // Log fetched students for debugging
      // print("Fetched students: $studentsFromDb");
    } finally {
      isLoading(false);
    }
  }

  void addStudent(Student student) async {
    // Format tanggalLahir ke format YYYY-MM-DD sebelum menyimpan
    student.tanggalLahir = formatDateForDb(student.tanggalLahir);
    await DBHelper().insertStudent(student);
    fetchStudents();
  }

  void updateStudent(Student student) async {
    // Format tanggalLahir ke format YYYY-MM-DD sebelum menyimpan
    student.tanggalLahir = formatDateForDb(student.tanggalLahir);
    await DBHelper().updateStudent(student);
    fetchStudents();
  }

  void deleteStudent(int id) async {
    await DBHelper().deleteStudent(id);
    fetchStudents();
  }

  // Fungsi untuk format tanggal ke format YYYY-MM-DD
  String? formatDateForDb(String? date) {
    if (date == null) return null;
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  // Fungsi untuk format tanggal ke format DD-MM-YYYY (untuk ditampilkan)
  String? formatDateForDisplay(String? date) {
    if (date == null) return null;
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd-MM-yyyy');
    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }
}
