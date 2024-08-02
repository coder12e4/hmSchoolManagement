import 'package:bloc/bloc.dart';
import 'package:hamonschoolmanagement/models/roomModel.dart';
import 'package:meta/meta.dart';

import '../../Repository/getClassRepository.dart';

part 'class_room_state.dart';

class ClassRoomCubit extends Cubit<ClassRoomState> {
  final getClassRepository getClassRoomRepo;
  ClassRoomCubit(this.getClassRoomRepo) : super(ClassRoomInitial());

  Future<void> loadStudentData() async {
    emit(ClassRoomLoading());
    try {
      roomModel? objstudentList = await getClassRoomRepo.getClass("");
      emit(ClassRoomSuccess(objstudentList));
    } catch (e) {
      print(e);
      emit(ClassRoomFailed("empty"));
    }
  }
}
