part of 'class_room_cubit.dart';

@immutable
sealed class ClassRoomState {}

final class ClassRoomInitial extends ClassRoomState {}

final class ClassRoomLoading extends ClassRoomState {}

final class ClassRoomSuccess extends ClassRoomState {
  final roomModel roommodel;

  ClassRoomSuccess(this.roommodel);
}

final class ClassRoomFailed extends ClassRoomState {
  String error;

  ClassRoomFailed(this.error);
}
