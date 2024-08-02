import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hamonschoolmanagement/models/subjectList.dart';

import '../../core/commonwidgets/commonWidgets/commonWidgets.dart';
import '../../models/studentModel.dart';

class SubjectDetailpage extends StatefulWidget {
  final Subjects subject;
  const SubjectDetailpage({super.key, required this.subject});

  @override
  State<SubjectDetailpage> createState() => _SubjectDetailpageState();
}

class _SubjectDetailpageState extends State<SubjectDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          const SizedBox(
            height: 20,
          ),
          const hmTxtLarge(text: "Subject Detail"),
          const SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "https://www.timeshighereducation.com/student/sites/default/files/styles/default/public/istock-487602560.jpg?itok=FuR3XnlP",
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              hmTxtMedium(text: widget.subject.name!),
              const SizedBox(
                height: 8,
              ),
              hmTxtMedium(text: widget.subject.teacher!),
              const SizedBox(
                height: 8,
              ),
              hmTxtSmall(text: "Credit : ${widget.subject.credits!}")
            ],
          ),
          const Expanded(
            child: SizedBox(),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
