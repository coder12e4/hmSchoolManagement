import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamonschoolmanagement/Repository/getClassRepository.dart';
import 'package:hamonschoolmanagement/models/roomModel.dart';

import '../../core/Contants/colors.dart';
import '../../core/commonwidgets/commonWidgets/commonWidgets.dart';
import '../../cubit/classRoom/class_room_cubit.dart';
import 'classRoomView.dart';

class classRoomList extends StatefulWidget {
  const classRoomList({super.key});

  @override
  State<classRoomList> createState() => _classRoomListState();
}

class _classRoomListState extends State<classRoomList> {
  late ClassRoomCubit classRoomCubit;
  late roomModel objclassRoomList;
  @override
  void initState() {
    // TODO: implement initState
    classRoomCubit = ClassRoomCubit(getClassRepository());
    classRoomCubit.loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<ClassRoomCubit>(
        create: (context) => classRoomCubit,
        child: BlocListener<ClassRoomCubit, ClassRoomState>(
          bloc: classRoomCubit,
          listener: (context, state) {
            if (state is ClassRoomLoading) {
            } else if (state is ClassRoomSuccess) {
              objclassRoomList = state.roommodel;
            } else if (state is ClassRoomFailed) {
            } else {}
          },
          child: BlocBuilder<ClassRoomCubit, ClassRoomState>(
            builder: (context, state) {
              if (state is ClassRoomLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ClassRoomSuccess) {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      hmTxtLarge(text: "Class Rooms"),
                      Expanded(
                          child: ListView.builder(
                              itemCount: objclassRoomList.classrooms!.length,
                              itemBuilder: (context, intex) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => classRoomView(
                                                  classrooms: objclassRoomList
                                                      .classrooms![intex],
                                                )));
                                  },
                                  child: Container(
                                    height: 60,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 0, right: 0),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HmColors.listBackgroundGray),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            hmTxtMedium(
                                              text: objclassRoomList
                                                  .classrooms![intex].name!,
                                            ),
                                            hmTxtSmall(
                                                text: objclassRoomList
                                                    .classrooms![intex].layout!)
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            hmTxtMedium(
                                              text: objclassRoomList
                                                  .classrooms![intex].size!
                                                  .toString(),
                                            ),
                                            hmTxtSmall(text: "Seats")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
                );
              } else if (state is ClassRoomFailed) {
                return Center(
                  child: Icon(
                    Icons.hourglass_empty,
                    size: 24,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
