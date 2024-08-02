import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';
import 'package:http/http.dart' as http;
import '../core/Api/apiControlller.dart';
import '../models/classUpdateModel.dart';
import '../models/classUpdateModel.dart';
import '../models/classUpdateModel.dart';
import '../models/roomModel.dart';
import '../models/studentModel.dart';
import '../models/subjectList.dart';

abstract class GetClassRepository {
  Future<roomModel> getClass(String apikey);
  Future<updateClassSubject> updateSubject(int classid, int subjectId);
  Future<subjectList> getSubjectList();
}

class getClassRepository extends GetClassRepository {
  ApiController apiController = ApiController();

  @override
  Future<roomModel> getClass(String apikey) async {
    var classroomModel = await ApiController()
        .getData("classrooms/?api_key=" + Apiconstants.apiKey);
    roomModel objClassRoomList = roomModel.fromJson(classroomModel);
    return objClassRoomList;
  }

  @override
  Future<updateClassSubject> updateSubject(int classid, int subjectId) async {
    var ObjupdateClassSubject =
        await ApiController().updateClassroom(classid, subjectId);
    updateClassSubject objClassRoomList =
        updateClassSubject.fromJson(ObjupdateClassSubject);
    return objClassRoomList;
  }

  @override
  Future<subjectList> getSubjectList() async {
    var SubjectListrsp =
        await ApiController().getData("subjects/?api_key=D74Fb");
    subjectList objStudentList = subjectList.fromJson(SubjectListrsp);
    return objStudentList;
  }
}
