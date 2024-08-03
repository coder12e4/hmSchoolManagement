import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';
import '../core/Api/apiControlller.dart';
import '../models/classUpdateModel.dart';
import '../models/roomModel.dart';
import '../models/subjectList.dart';

abstract class GetClassRepository {
  Future<roomModel> getClass(String apikey);
  Future<updateClassSubject> updateSubject(int classid, int subjectId);
  Future<subjectList> getSubjectList();
}

class GetClassRepos extends GetClassRepository {
  ApiController apiController = ApiController();

  @override
  Future<roomModel> getClass(String apikey) async {
    var classroomModel = await ApiController()
        .getData("classrooms/?api_key=${Apiconstants.apiKey}");
    roomModel objClassRoomList = roomModel.fromJson(classroomModel);
    return objClassRoomList;
  }

  @override
  Future<updateClassSubject> updateSubject(int classid, int subjectId) async {
    var objupdateClassSubject =
        await ApiController().updateClassroom(classid, subjectId);
    updateClassSubject objClassRoomList =
        updateClassSubject.fromJson(objupdateClassSubject);
    return objClassRoomList;
  }

  @override
  Future<subjectList> getSubjectList() async {
    var subjectListrsp =
        await ApiController().getData("subjects/?api_key=D74Fb");
    subjectList objStudentList = subjectList.fromJson(subjectListrsp);
    return objStudentList;
  }
}
