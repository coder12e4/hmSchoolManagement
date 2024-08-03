import 'package:bloc/bloc.dart';
import 'package:hamonschoolmanagement/models/registerModels/detailsOfStudent.dart';
import 'package:hamonschoolmanagement/models/registerModels/registerModels.dart';
import 'package:hamonschoolmanagement/models/subjectList.dart';
import 'package:meta/meta.dart';

import '../../Repository/getRegistrationsRepo.dart';
import '../../models/registerModels/StudentRegisterModel.dart';
import '../../models/studentModel.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GetRegitrationRepository getRegitrationRepository;
  RegisterCubit(this.getRegitrationRepository) : super(RegisterInitial());

  late registerList objRegistrationList1;

  Future<void> getRegistrations() async {
    try {
      emit(RegisterListLoading());
      registerList objRegistrationList =
          await getRegitrationRepository.getRegisterList();
      objRegistrationList1 = objRegistrationList;
      emit(RegisterListSuccess(objRegistrationList));
    } catch (e) {
      print(e);
      emit(RegisterListFail("error"));
    }
  }

  Future<void> getRegisterpage() async {
    try {
      emit(RegisterSceenInitial());
    } catch (e) {
      print(e);
      emit(RegisterListFail("error"));
    }
  }

  Future<void> loadStudentData() async {
    emit(RegisterStudentListLoading());
    try {
      studentList? objstudentList =
          await getRegitrationRepository.getStudent("");
      emit(RegisterStudentListSuccess(objstudentList));
    } catch (e) {
      print(e);
      emit(RegisterStudentListFail("empty"));
    }
  }

  Future<void> loadSubjectData() async {
    emit(RegisterSubjectListLoading());
    try {
      subjectList? objSubjectList =
          await getRegitrationRepository.getSubjectList();
      emit(RegisterSubjectListSuccess(objSubjectList));
    } catch (e) {
      print(e);
      emit(RegisterStudentListFail("empty"));
    }
  }

  Future<void> registerStudent(int student, int subject) async {
    emit(RegisterListLoading());
    try {
      StudentRegisterModel? obj =
          await getRegitrationRepository.registerStudent(student, subject);

      getRegistrations();
    } catch (e) {
      print(e);
      emit(RegisterStudentListFail("empty"));
    }
  }

  Future<void> GetRegisterStudentDetails(String id) async {
    emit(RegisterSubjectListLoading());
    try {
      DetailsOfStudent? obj =
          await getRegitrationRepository.getDetailsOfSudent(id);
      subjectList? objSubjectList =
          await getRegitrationRepository.getSubjectList();
      studentList? objstudentList =
          await getRegitrationRepository.getStudent("");

      emit(RegisterStudentAndSubjectDetailsSucces(
          obj,
          objstudentList.students![obj.student!],
          objSubjectList.subjects![obj.subject!]));
    } catch (e) {
      print(e);
      emit(RegisterStudentAndSubjectDetailsFail("empty"));
    }
  }
}
