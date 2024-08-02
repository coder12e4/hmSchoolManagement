import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Repository/getClassRepository.dart';
import '../../../models/classUpdateModel.dart';
import '../../../models/subjectList.dart';

part 'class_update_state.dart';

class ClassUpdateCubit extends Cubit<ClassUpdateState> {
  getClassRepository objClassrepository;

  ClassUpdateCubit(this.objClassrepository) : super(ClassUpdateInitial());

  Future<void> loadSubjectsData() async {
    emit(ClassUpdateLoadSubjects());
    try {
      subjectList? objSubjectList = await objClassrepository.getSubjectList();
      emit(ClassUpdateLoadSubjectSuccess(objSubjectList));
    } catch (e) {
      print(e);
      emit(ClassUpdateLoadFailed("empty"));
    }
  }

  Future<void> addSubjectToClassData(int classid, int subjectId) async {
    emit(ClassUpdateLoadSubjects());
    try {
      emit(ClassUpdateLoding());
      updateClassSubject? objClassUpdateSubjectDetails =
          await objClassrepository.updateSubject(classid, subjectId);
      emit(ClassUpdateSuccess(objClassUpdateSubjectDetails));
    } catch (e) {
      print(e);
      emit(ClassUpdateLoadFailed("empty"));
    }
  }
}
