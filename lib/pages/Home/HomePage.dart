import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamonschoolmanagement/core/commonwidgets/commonWidgets/commonWidgets.dart';
import 'package:hamonschoolmanagement/cubit/home/home_cubit.dart';
import 'package:hamonschoolmanagement/pages/RegistrationPage/RegistrationPage.dart';
import 'package:hamonschoolmanagement/pages/student/studentListPage.dart';
import 'package:hamonschoolmanagement/pages/subjects/subjectListPage.dart';

import '../classroom/classroom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = HomeCubit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeCubit>(
        create: (context) => homeCubit,
        child: BlocListener<HomeCubit, HomeState>(
            bloc: homeCubit,
            listener: (context, state) {
              if (state is HomeInitial) {
              } else if (state is HomeGrid) {
              } else if (state is HomeList) {}
            },
            child: SafeArea(
              child: Container(
                  margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    hmTxtLarge(text: "Hello"),
                                    hmTxtMedium(text: "Good Mornig")
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      homeCubit.homestate();
                                    },
                                    child: context.watch<HomeCubit>().k
                                        ? Image.asset("assets/images/grid.png")
                                        : Image.asset("assets/images/menu.png"))
                              ],
                            ),
                            context.watch<HomeCubit>().k
                                ? buildGridView()
                                : buildListView()
                          ],
                        );
                      })),
            )),
      ),
    );
  }

  Widget buildGridView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigatorSwitch(homeCubit.homeUiData[index].text);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: homeCubit.homeUiData[index].color,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/images/${homeCubit.homeUiData[index].icons}"),
                  hmTxtMedium(text: homeCubit.homeUiData[index].text)
                ],
              ),
            ),
          );
        },
        itemCount: homeCubit.homeUiData.length,
      ),
    );
  }

  Widget buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: homeCubit.homeUiData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigatorSwitch(homeCubit.homeUiData[index].text);
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(left: 0, right: 0, top: 20),
              decoration: BoxDecoration(
                  color: homeCubit.homeUiData[index].color,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              alignment: Alignment.center,
              child: hmTxtMedium(text: homeCubit.homeUiData[index].text),
            ),
          );
        },
      ),
    );
  }

  void navigatorSwitch(String key) {
    switch (key) {
      case "Class room":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ClassRoomList()));
        break;
      case "Students":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StudentListPage()));
        break;
      case "Subjects":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SubjectListPage()));
        break;
      case "Registration":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegistrationPage()));
        break;
    }
  }
}
