import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamonschoolmanagement/Repository/getRegistrationsRepo.dart';
import 'package:hamonschoolmanagement/models/registerModels/registerModels.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/Contants/colors.dart';
import '../../core/commonwidgets/commonWidgets/commonWidgets.dart';
import '../../cubit/register/register_cubit.dart';
import '../../models/studentModel.dart';
import '../../models/subjectList.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late RegisterCubit registerCubit;

  late subjectList objSubjectList;
  late studentList objstudentList;
  late registerList objRegistrationList;
  late Students objectStudent;
  late Subjects objsubjects;
  String studentName = "Select a student";
  String studentSubject = "Select a subject";

  @override
  void initState() {
    registerCubit = RegisterCubit(GetRegitrationRepository());
    registerCubit.getRegistrations();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterCubit>(
        create: (context) => registerCubit,
        child: BlocListener<RegisterCubit, RegisterState>(
          bloc: registerCubit,
          listener: (context, state) {
            if (state is RegisterListLoading) {
            } else if (state is RegisterListSuccess) {
              objRegistrationList = state.objRegisterList;
            } else if (state is RegisterListFail) {
            } else if (state is RegisterSceenInitial) {
            } else if (state is RegisterStudentListLoading) {
            } else if (state is RegisterStudentListSuccess) {
              objstudentList = state.objstudentList;
            } else if (state is RegisterStudentListFail) {
            } else if (state is RegisterSubjectListLoading) {
            } else if (state is RegisterSubjectListSuccess) {
              objSubjectList = state.objSubjectList;
            } else if (state is RegisterSubjectListFail) {
            } else if (state is RegisterStudentAndSubjectDetailsLOading) {
            } else if (state is RegisterStudentAndSubjectDetailsSucces) {
            } else if (state is RegisterStudentAndSubjectDetailsFail) {}
          },
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is RegisterListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterListSuccess) {
                return Container(
                  padding: EdgeInsets.all(16),
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
                      const hmTxtLarge(text: "Register"),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount:
                                  objRegistrationList.registrations!.length,
                              itemBuilder: (context, intex) {
                                return objRegistrationList
                                        .registrations!.isEmpty
                                    ? const hmTxtSmall(
                                        text: "No Data",
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          registerCubit
                                              .GetRegisterStudentDetails(
                                                  objRegistrationList
                                                      .registrations![intex].id!
                                                      .toString());
                                        },
                                        child: Container(
                                          height: 60,
                                          margin: EdgeInsets.only(
                                              top: 10, left: 0, right: 0),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  HmColors.listBackgroundGray),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              hmTxtLarge(
                                                text: "Registration Id : " +
                                                    objRegistrationList
                                                        .registrations![intex]
                                                        .id!
                                                        .toString(),
                                              ),
                                              Icon(Icons.chevron_right)
                                            ],
                                          ),
                                        ),
                                      );
                              })),
                      GestureDetector(
                        onTap: () {
                          registerCubit.getRegisterpage();
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor("007AFF").withOpacity(.1)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "New Registration",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              } else if (state is RegisterListFail) {
                return Container();
              } else if (state is RegisterSceenInitial) {
                return Container(
                  padding: EdgeInsets.all(16),
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
                      const hmTxtLarge(text: "Register"),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerCubit.loadStudentData();
                        },
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HmColors.listBackgroundGray),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              hmTxtMedium(
                                text: studentName,
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerCubit.loadSubjectData();
                        },
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HmColors.listBackgroundGray),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              hmTxtMedium(
                                text: studentSubject,
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              registerCubit.registerStudent(
                                  objectStudent.id!, objsubjects.id!);
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: HexColor("0FAB76")),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else if (state is RegisterStudentListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterStudentListSuccess) {
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
                      const hmTxtLarge(text: "Students"),
                      Expanded(
                          child: ListView.builder(
                              itemCount: objstudentList.students!.length,
                              itemBuilder: (context, intex) {
                                return GestureDetector(
                                  onTap: () {
                                    objectStudent =
                                        objstudentList.students![intex];
                                    studentName = objectStudent.name!;
                                    registerCubit.getRegisterpage();
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
                                              text: objstudentList
                                                  .students![intex].name!,
                                            ),
                                            hmTxtSmall(
                                                text: objstudentList
                                                    .students![intex].email!)
                                          ],
                                        ),
                                        hmTxtMedium(
                                          text:
                                              "Age : ${objstudentList.students![intex].age!.toString()}",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
                );
              } else if (state is RegisterStudentListFail) {
                return Container();
              } else if (state is RegisterSubjectListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterSubjectListSuccess) {
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
                                    objsubjects =
                                        objSubjectList.subjects![intex];
                                    studentSubject = objsubjects.name!;
                                    registerCubit.getRegisterpage();
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
              } else if (state is RegisterSubjectListFail) {
                return Container();
              } else if (state is RegisterStudentAndSubjectDetailsLOading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RegisterStudentAndSubjectDetailsSucces) {
                return Container(
                  padding: EdgeInsets.all(16),
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
                      const hmTxtLarge(text: "Register"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HmColors.listBackgroundGray),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hmTxtMedium(
                                  text: "Student details",
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(
                                  text: state.objectStudent.name!,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(text: state.objectStudent.email!)
                              ],
                            ),
                            hmTxtSmall(
                              text:
                                  "Age : ${state.objectStudent.age!.toString()}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HmColors.listBackgroundGray),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hmTxtMedium(
                                  text: "Subject details",
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(
                                  text: state.objsubjects.name!,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(text: state.objsubjects.teacher!)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                hmTxtSmall(
                                  text: state.objsubjects.credits!.toString(),
                                ),
                                hmTxtSmall(
                                  text: "Credits".toString(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              registerCubit.registerStudent(
                                  objectStudent.id!, objsubjects.id!);
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: HexColor("F9614F")),
                              child: Text(
                                "Delete Registration",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else if (state is RegisterStudentAndSubjectDetailsFail) {
                return Center(
                  child: Text("fail"),
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
