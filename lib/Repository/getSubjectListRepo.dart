import '../core/Api/apiControlller.dart';
import '../models/subjectList.dart';

abstract class SubjectListRepo {
  Future<subjectList> getSubjectList();
}

class Getsubjectlistrepository extends SubjectListRepo {
  ApiController apiController = ApiController();
  @override
  Future<subjectList> getSubjectList() async {
    var subjectListrsp =
        await ApiController().getData("subjects/?api_key=D74Fb");
    subjectList objStudentList = subjectList.fromJson(subjectListrsp);
    return objStudentList;
  }
}
