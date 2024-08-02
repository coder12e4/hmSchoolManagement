import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';
import 'package:http/http.dart' as http;
import '../core/Api/apiControlller.dart';
import '../models/classUpdateModel.dart';
import '../models/classUpdateModel.dart';
import '../models/classUpdateModel.dart';
import '../models/roomModel.dart';
import '../models/studentModel.dart';

abstract class GetClassRepository {
  Future<roomModel> getClass(String apikey);
  Future<updateClassSubject> updateSubject(String subjectId);
}

class getClassRepository extends GetClassRepository {
  ApiController apiController = ApiController();

  @override
  Future<roomModel> getClass(String classroomId, String apikey) async {
    var classroomModel = await ApiController()
        .getData("classrooms/?api_key=" + Apiconstants.apiKey);
    roomModel objClassRoomList = roomModel.fromJson(classroomModel);
    return objClassRoomList;
  }

  @override
  Future<updateClassSubject> updateSubject(
      String classroomId, String subjectId) async {
    var ObjupdateClassSubject = await ApiController()
        .updateClassroom(int.parse(classroomId), int.parse(subjectId));
    updateClassSubject objClassRoomList =
        updateClassSubject.fromJson(ObjupdateClassSubject);
    return objClassRoomList;
  }
}
