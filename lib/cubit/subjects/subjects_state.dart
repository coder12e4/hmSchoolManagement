part of 'subjects_cubit.dart';

@immutable
sealed class SubjectsState {}

final class SubjectsInitial extends SubjectsState {}

final class SubjectsLoading extends SubjectsState {}

final class SubjectsSuccess extends SubjectsState {
  subjectList? objSubjectList;
  SubjectsSuccess(this.objSubjectList);
}

final class SubjectsError extends SubjectsState {
  String error;
  SubjectsError(this.error);
}
