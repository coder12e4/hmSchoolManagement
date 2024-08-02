import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'class_update_state.dart';

class ClassUpdateCubit extends Cubit<ClassUpdateState> {
  ClassUpdateCubit() : super(ClassUpdateInitial());
}
