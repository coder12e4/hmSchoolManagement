part of 'class_update_cubit.dart';

@immutable
sealed class ClassUpdateState {}

final class ClassUpdateInitial extends ClassUpdateState {}

final class ClassUpdateLoding extends ClassUpdateState {}

final class ClassUpdateSuccess extends ClassUpdateState {}

final class ClassUpdateFailed extends ClassUpdateState {}
