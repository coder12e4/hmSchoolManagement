part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterListLoading extends RegisterState {}

final class RegisterListSuccess extends RegisterState {
  registerList objRegisterList;
  RegisterListSuccess(this.objRegisterList);
}

final class RegisterListFail extends RegisterState {
  String error;
  RegisterListFail(this.error);
}

final class RegisterSceenInitial extends RegisterState {}

final class RegisterStudentListLoading extends RegisterState {}

final class RegisterStudentListSuccess extends RegisterState {
  studentList objstudentList;

  RegisterStudentListSuccess(this.objstudentList);
}

final class RegisterStudentListFail extends RegisterState {
  String error;
  RegisterStudentListFail(this.error);
}

final class RegisterSubjectListLoading extends RegisterState {}

final class RegisterSubjectListSuccess extends RegisterState {
  subjectList objSubjectList;

  RegisterSubjectListSuccess(this.objSubjectList);
}

final class RegisterSubjectListFail extends RegisterState {
  String error;
  RegisterSubjectListFail(this.error);
}

final class RegisterStudentAndSubjectDetailsLOading extends RegisterState {}

final class RegisterStudentAndSubjectDetailsSucces extends RegisterState {
  DetailsOfStudent detailsOfStudent;
  Students objectStudent;

  RegisterStudentAndSubjectDetailsSucces(
      this.detailsOfStudent, this.objectStudent, this.objsubjects);

  Subjects objsubjects;
}

final class RegisterStudentAndSubjectDetailsFail extends RegisterState {
  String Error;

  RegisterStudentAndSubjectDetailsFail(this.Error);
}

final class deletLoding extends RegisterState {}

final class deletSuccess extends RegisterState {}

final class deletfail extends RegisterState {}
