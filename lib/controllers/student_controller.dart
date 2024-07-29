import 'package:get/get.dart';
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
    } finally {
      isLoading(false);
    }
  }

  void addStudent(Student student) async {
    await DBHelper().insertStudent(student);
    fetchStudents();
  }

  void updateStudent(Student student) async {
    await DBHelper().updateStudent(student);
    fetchStudents();
  }

  void deleteStudent(String id) async {
    await DBHelper().deleteStudent(int.parse(id));
    fetchStudents();
  }
}
