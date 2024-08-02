import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/Contants/colors.dart';
import '../../models/homeDeskModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  bool k = true;
  List<HomeDeskmodel> homeUiData = [
    HomeDeskmodel(HmColors.homeGreen, "Students", "student.png"),
    HomeDeskmodel(HmColors.homeBlue, "Subjects", "book.png"),
    HomeDeskmodel(HmColors.homeOrage, "Class room", "con.png"),
    HomeDeskmodel(HmColors.homeYellow, "Registration", "group.png"),
  ];

  void homestate() {
    k = !k;
    k ? emit(HomeGrid()) : emit(HomeList());
  }
}
