import '../core/Api/apiControlller.dart';
import '../models/studentModel.dart';

abstract class Getstudentsrepository {
  Future<studentList> getStudent(String apikey);
}

class StudentListRepo extends Getstudentsrepository {
  ApiController apiController = ApiController();
  @override
  Future<studentList> getStudent(String apikey) async {
    var studentListj = await ApiController().getData("students/?api_key=D74Fb");
    studentList objStudentList = studentList.fromJson(studentListj);
    return objStudentList;
  }
}
