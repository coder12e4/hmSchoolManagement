import 'package:bloc/bloc.dart';
import 'package:hamonschoolmanagement/models/studentModel.dart';
import 'package:meta/meta.dart';

import '../../Repository/getStudentsRepository.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  final Getstudentsrepository getstudentsrepository;
  StudentListCubit(this.getstudentsrepository) : super(StudentListInitial());

  Future<void> loadStudentData() async {
    emit(StudentListLoding());
    try {
      studentList? objstudentList = await getstudentsrepository.getStudent("");
      emit(StudentListSucces(objstudentList));
    } catch (e) {
      print(e);
      emit(StudentListFail("empty"));
    }
  }
}
