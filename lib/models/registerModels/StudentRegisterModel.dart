class StudentRegisterModel {
  Registration? registration;

  StudentRegisterModel({this.registration});

  StudentRegisterModel.fromJson(Map<String, dynamic> json) {
    registration = json['registration'] != null
        ? new Registration.fromJson(json['registration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.registration != null) {
      data['registration'] = this.registration!.toJson();
    }
    return data;
  }
}

class Registration {
  int? id;
  int? student;
  int? subject;

  Registration({this.id, this.student, this.subject});

  Registration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    student = json['student'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student'] = this.student;
    data['subject'] = this.subject;
    return data;
  }
}
