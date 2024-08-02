part of 'student_list_cubit.dart';

@immutable
sealed class StudentListState {}

final class StudentListInitial extends StudentListState {}

final class StudentListLoding extends StudentListState {}

final class StudentListSucces extends StudentListState {
  studentList objStudentList;

  StudentListSucces(this.objStudentList);
}

final class StudentListFail extends StudentListState {
  String error;
  StudentListFail(this.error);
}
