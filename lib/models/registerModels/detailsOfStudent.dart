class DetailsOfStudent {
  int? id;
  int? student;
  int? subject;

  DetailsOfStudent({this.id, this.student, this.subject});

  DetailsOfStudent.fromJson(Map<String, dynamic> json) {
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
