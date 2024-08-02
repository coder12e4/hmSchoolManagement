import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';
import 'package:http/http.dart' as http;
import '../core/Api/apiControlller.dart';
import '../models/roomModel.dart';
import '../models/studentModel.dart';

abstract class GetClassRepository {
  Future<roomModel> getClass(String apikey);
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
}
