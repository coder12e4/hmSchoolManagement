import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Repository/getClassRepository.dart';
import '../../core/Contants/colors.dart';
import '../../core/commonwidgets/commonWidgets/commonWidgets.dart';
import '../../cubit/classRoom/classRoomUpdate/class_update_cubit.dart';
import '../../cubit/classRoom/class_room_cubit.dart';
import '../../models/classUpdateModel.dart';
import '../../models/roomModel.dart';
import '../../models/subjectList.dart';

class classRoomView extends StatefulWidget {
  final Classrooms classrooms;
  const classRoomView({super.key, required this.classrooms});

  @override
  State<classRoomView> createState() => _classRoomViewState();
}

class _classRoomViewState extends State<classRoomView> {
  late ClassUpdateCubit classRoomUpdateCubit;
  late Classrooms objclassrooms;
  late subjectList objSubjectList;
  late updateClassSubject objUpdateSuccess;

  @override
  void initState() {
    classRoomUpdateCubit = ClassUpdateCubit(getClassRepository());
    objclassrooms = widget.classrooms;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ClassUpdateCubit>(
        create: (context) => classRoomUpdateCubit,
        child: BlocListener<ClassUpdateCubit, ClassUpdateState>(
          listener: (context, state) {
            if (state is ClassUpdateInitial) {
            } else if (state is ClassRoomSuccess) {
            } else if (state is ClassUpdateLoadSubjectSuccess) {
              objSubjectList = state.objSubjectList!;
            } else if (state is ClassUpdateSuccess) {
              objUpdateSuccess = state.obj;
            }
          },
          child: BlocBuilder<ClassUpdateCubit, ClassUpdateState>(
            builder: (context, state) {
              if (state is ClassUpdateInitial) {
                return Column(
                  children: [
                    const SizedBox(
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
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                    hmTxtLarge(text: widget.classrooms.name!),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: HmColors.listBackgroundGray,
                          borderRadius: BorderRadius.circular(4)),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          hmTxtMedium(text: "Add Subject"),
                          GestureDetector(
                            onTap: () {
                              classRoomUpdateCubit.loadSubjectsData();
                            },
                            child: Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: HmColors.homeGreen),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: HexColor("0FAB76"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    widget.classrooms.layout == "conference"
                        ? layoutConference()
                        : layoutClassRoom()
                  ],
                );
              } else if (state is ClassUpdateLoadSubjects) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ClassUpdateLoadSubjectSuccess) {
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
                      const hmTxtLarge(text: "Subjects"),
                      Expanded(
                          child: ListView.builder(
                              itemCount: objSubjectList.subjects!.length,
                              itemBuilder: (context, intex) {
                                return GestureDetector(
                                  onTap: () {
                                    classRoomUpdateCubit.addSubjectToClassData(
                                        int.parse("${objclassrooms.id}"),
                                        int.parse(
                                            "${objSubjectList.subjects![intex].id}"));
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
                                              text: objSubjectList
                                                  .subjects![intex].name!,
                                            ),
                                            hmTxtSmall(
                                                text: objSubjectList
                                                    .subjects![intex].teacher!)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            hmTxtMedium(
                                              text: objSubjectList
                                                  .subjects![intex].credits!
                                                  .toString(),
                                            ),
                                            hmTxtMedium(
                                              text: "Credits".toString(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
                );
              } else if (state is ClassUpdateSuccess) {
                return Column(
                  children: [
                    const SizedBox(
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
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                    hmTxtLarge(text: widget.classrooms.name!),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: HmColors.listBackgroundGray,
                          borderRadius: BorderRadius.circular(4)),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hmTxtMedium(
                                  text: objSubjectList
                                      .subjects![objUpdateSuccess.subject! - 1]
                                      .name!),
                              hmTxtSmall(
                                  text: objSubjectList
                                      .subjects![objUpdateSuccess.subject! - 1]
                                      .teacher!),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              classRoomUpdateCubit.loadSubjectsData();
                            },
                            child: Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: HmColors.homeGreen),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: HexColor("0FAB76"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    widget.classrooms.layout == "conference"
                        ? layoutConference()
                        : layoutClassRoom(),
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: HmColors.homeGreen),
                      child: Text(
                        "Subject Updated",
                        style: TextStyle(
                          color: HexColor("0FAB76"),
                        ),
                      ),
                    )
                  ],
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

  Widget layoutConference() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/sitting.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "assets/images/sitting.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "assets/images/sitting.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "assets/images/sitting.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "assets/images/sitting.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
          Container(
            width: 120,
            height: MediaQuery.of(context).size.height * 0.3,
            color: HmColors.listBackgroundGray,
          ),
          Container(
            child: Column(
              children: [
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/images/sitting.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/images/sitting.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/images/sitting.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/images/sitting.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    "assets/images/sitting.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget layoutClassRoom() {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      width: MediaQuery.of(context).size.width * .5,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: 20,
          itemBuilder: (context, inted) {
            return Container(
              margin: EdgeInsets.all(2),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Image.asset(
                "assets/images/sitting.png",
                height: 24,
                width: 24,
              ),
            );
          }),
    );
  }
}
