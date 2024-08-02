import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamonschoolmanagement/Repository/getStudentsRepository.dart';
import 'package:hamonschoolmanagement/core/commonwidgets/commonWidgets/commonWidgets.dart';
import 'package:hamonschoolmanagement/cubit/studentList/student_list_cubit.dart';
import 'package:hamonschoolmanagement/cubit/subjects/subjects_cubit.dart';
import 'package:hamonschoolmanagement/models/studentModel.dart';
import 'package:hamonschoolmanagement/models/subjectList.dart';
import 'package:hamonschoolmanagement/pages/student/DetailPage.dart';
import 'package:hamonschoolmanagement/pages/subjects/subjectDetailPage.dart';

import '../../Repository/getSubjectListRepo.dart';
import '../../core/Contants/colors.dart';

class SubjectListPage extends StatefulWidget {
  const SubjectListPage({super.key});

  @override
  State<SubjectListPage> createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  late SubjectsCubit subjectsCubit;
  late subjectList objSubjectList;
  @override
  void initState() {
    // TODO: implement initState
    subjectsCubit = SubjectsCubit(Getsubjectlistrepository());
    subjectsCubit.loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<SubjectsCubit>(
        create: (context) => subjectsCubit,
        child: BlocListener<SubjectsCubit, SubjectsState>(
          bloc: subjectsCubit,
          listener: (context, state) {
            if (state is SubjectsLoading) {
            } else if (state is SubjectsSuccess) {
              objSubjectList = state.objSubjectList!;
            } else if (state is SubjectsError) {
            } else {}
          },
          child: BlocBuilder<SubjectsCubit, SubjectsState>(
            builder: (context, state) {
              if (state is SubjectsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SubjectsSuccess) {
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubjectDetailpage(
                                                    subject: objSubjectList
                                                        .subjects![intex])));
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
              } else if (state is SubjectsError) {
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
