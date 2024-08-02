import 'dart:convert';
import 'package:hamonschoolmanagement/core/Contants/apiConstants.dart';
import 'package:http/http.dart' as http;

class ApiController {
  //final String baseUrl;

  ApiController();

  Future<dynamic> getData(String endpoint) async {
    final response = await http
        .get(Uri.parse('https://nibrahim.pythonanywhere.com/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('https://nibrahim.pythonanywhere.com/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<dynamic> updateClassroom(
    int classroomId1,
    int subjectId1,
  ) async {
    String classroomId = classroomId1.toString();
    String subjectId = subjectId1.toString();

    final url = Uri.parse(
        'http://nibrahim.pythonanywhere.com/classrooms/$classroomId?api_key=${Apiconstants.apiKey}');
    print(url);
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'subject': subjectId,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Update');
    }
  }
}
