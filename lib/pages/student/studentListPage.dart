import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamonschoolmanagement/Repository/getStudentsRepository.dart';
import 'package:hamonschoolmanagement/core/commonwidgets/commonWidgets/commonWidgets.dart';
import 'package:hamonschoolmanagement/cubit/studentList/student_list_cubit.dart';
import 'package:hamonschoolmanagement/models/studentModel.dart';
import 'package:hamonschoolmanagement/pages/student/DetailPage.dart';

import '../../core/Contants/colors.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late StudentListCubit studentListCubit;
  late studentList objstudentList;

  @override
  void initState() {
    studentListCubit = StudentListCubit(StudentListRepo());
    studentListCubit.loadStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<StudentListCubit>(
        create: (context) => studentListCubit,
        child: BlocListener<StudentListCubit, StudentListState>(
          bloc: studentListCubit,
          listener: (context, state) {
            if (state is StudentListLoding) {
            } else if (state is StudentListSucces) {
              objstudentList = state.objStudentList;
            } else if (state is StudentListFail) {
            } else {}
          },
          child: BlocBuilder<StudentListCubit, StudentListState>(
            builder: (context, state) {
              if (state is StudentListLoding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StudentListSucces) {
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => detailpage(
                                                students: objstudentList
                                                    .students![intex])));
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
              } else if (state is StudentListFail) {
                return const Center(
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
