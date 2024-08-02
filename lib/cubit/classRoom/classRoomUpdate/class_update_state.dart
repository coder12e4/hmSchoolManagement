part of 'class_update_cubit.dart';

@immutable
sealed class ClassUpdateState {}

final class ClassUpdateInitial extends ClassUpdateState {}

//
final class ClassUpdateLoadSubjects extends ClassUpdateState {}

final class ClassUpdateLoadSubjectSuccess extends ClassUpdateState {
  subjectList? objSubjectList;
  ClassUpdateLoadSubjectSuccess(this.objSubjectList);
}

final class ClassUpdateLoadFailed extends ClassUpdateState {
  String Error;
  ClassUpdateLoadFailed(this.Error);
}

//

final class ClassUpdateLoding extends ClassUpdateState {}

final class ClassUpdateSuccess extends ClassUpdateState {
  updateClassSubject obj;
  ClassUpdateSuccess(this.obj);
}

final class ClassUpdateFailed extends ClassUpdateState {}
