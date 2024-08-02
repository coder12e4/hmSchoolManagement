import 'package:bloc/bloc.dart';
import 'package:hamonschoolmanagement/models/subjectList.dart';
import 'package:meta/meta.dart';

import '../../Repository/getSubjectListRepo.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  final Getsubjectlistrepository getsubjectlistrepository;
  SubjectsCubit(this.getsubjectlistrepository) : super(SubjectsInitial());
  Future<void> loadStudentData() async {
    emit(SubjectsLoading());
    try {
      subjectList? objSubjectList =
          await getsubjectlistrepository.getSubjectList();
      emit(SubjectsSuccess(objSubjectList));
    } catch (e) {
      print(e);
      emit(SubjectsError("empty"));
    }
  }
}
