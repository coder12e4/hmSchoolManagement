import 'package:hamonschoolmanagement/core/Api/apiControlller.dart';
import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';

import '../models/registerModels/StudentRegisterModel.dart';

import '../models/registerModels/detailsOfStudent.dart';
import '../models/registerModels/registerModels.dart';
import '../models/studentModel.dart';
import '../models/subjectList.dart';

abstract class GetRegitrationRepo {
  Future<registerList> getRegisterList();
  Future<studentList> getStudent(String apikey);
  Future<subjectList> getSubjectList();
  Future<StudentRegisterModel> registerStudent(int student, int subject);
  Future<DetailsOfStudent> getDetailsOfSudent(String id);
}

class GetRegitrationRepository extends GetRegitrationRepo {
  ApiController apiController = ApiController();
  @override
  Future<registerList> getRegisterList() async {
    var objRegisterList = await apiController
        .getData("registration/?api_key=" + Apiconstants.apiKey);
    registerList objregisterList = registerList.fromJson(objRegisterList);
    return objregisterList;
  }

  @override
  Future<studentList> getStudent(String apikey) async {
    var studentListj = await ApiController().getData("students/?api_key=D74Fb");
    studentList objStudentList = studentList.fromJson(studentListj);
    return objStudentList;
  }

  @override
  Future<subjectList> getSubjectList() async {
    var SubjectListrsp =
        await ApiController().getData("subjects/?api_key=D74Fb");
    subjectList objStudentList = subjectList.fromJson(SubjectListrsp);
    return objStudentList;
  }

  @override
  Future<StudentRegisterModel> registerStudent(
      int? student, int? subject) async {
    try {
      var objregister = await ApiController().postData(
          "registration/?api_key=${Apiconstants.apiKey}", student, subject);
      StudentRegisterModel studentRegisterModel =
          StudentRegisterModel.fromJson(objregister);
      return studentRegisterModel;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<DetailsOfStudent> getDetailsOfSudent(String id) async {
    var objDetails = await apiController
        .getData("registration/$id?api_key=" + Apiconstants.apiKey);
    DetailsOfStudent obj = DetailsOfStudent.fromJson(objDetails);
    return obj;
  }
}
