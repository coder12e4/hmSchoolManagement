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

    super.initState();
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Do you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                registerCubit.deleteData(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              //   state.detailsOfStudent.id;
            } else if (state is RegisterStudentAndSubjectDetailsFail) {
            } else if (state is deletLoding) {
            } else if (state is deletSuccess) {
            } else if (state is deletfail) {}
          },
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is RegisterListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterListSuccess) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
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
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const hmTxtLarge(text: "Register"),
                      const SizedBox(
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
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 0, right: 0),
                                          padding: const EdgeInsets.all(10),
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
                                                text:
                                                    "Registration Id : ${objRegistrationList.registrations![intex].id!}",
                                              ),
                                              const Icon(Icons.chevron_right)
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
                          margin:
                              const EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: const EdgeInsets.all(10),
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
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              } else if (state is RegisterListFail) {
                return Container();
              } else if (state is RegisterSceenInitial) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
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
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const hmTxtLarge(text: "Register"),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerCubit.loadStudentData();
                        },
                        child: Container(
                          height: 60,
                          margin:
                              const EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: const EdgeInsets.all(10),
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
                              const Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerCubit.loadSubjectData();
                        },
                        child: Container(
                          height: 60,
                          margin:
                              const EdgeInsets.only(top: 10, left: 0, right: 0),
                          padding: const EdgeInsets.all(10),
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
                              const Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              child: const Text(
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterStudentListSuccess) {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Column(
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
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
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
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 0, right: 0),
                                    padding: const EdgeInsets.all(10),
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterSubjectListSuccess) {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Column(
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
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
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
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 0, right: 0),
                                    padding: const EdgeInsets.all(10),
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
                return const Center(child: CircularProgressIndicator());
              } else if (state is RegisterStudentAndSubjectDetailsSucces) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
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
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const hmTxtLarge(text: "Register"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        margin:
                            const EdgeInsets.only(top: 10, left: 0, right: 0),
                        padding: const EdgeInsets.all(10),
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
                                const hmTxtMedium(
                                  text: "Student details",
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(
                                  text: state.objectStudent.name!,
                                ),
                                const SizedBox(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        margin:
                            const EdgeInsets.only(top: 10, left: 0, right: 0),
                        padding: const EdgeInsets.all(10),
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
                                const hmTxtMedium(
                                  text: "Subject details",
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                hmTxtSmall(
                                  text: state.objsubjects.name!,
                                ),
                                const SizedBox(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showDeleteDialog(context,
                                  state.detailsOfStudent.id.toString());
                            },
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: HexColor("F9614F")),
                              child: const Text(
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
                return const Center(
                  child: Text("fail"),
                );
              } else if (state is deletLoding) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is deletSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'delete Successfull',
                    ),
                    backgroundColor: Colors.green.shade300,
                  ),
                );
                return Center(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.green,
                      child: const Text(
                        "User Deleted Successfully",
                        style: TextStyle(color: Colors.white),
                      )),
                );
              } else if (state is deletSuccess) {
                return const Center(
                  child: Text("SomeThing wrong try again"),
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
