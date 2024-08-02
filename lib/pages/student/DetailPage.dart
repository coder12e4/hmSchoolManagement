import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/commonwidgets/commonWidgets/commonWidgets.dart';
import '../../models/studentModel.dart';

class detailpage extends StatefulWidget {
  final Students students;
  const detailpage({super.key, required this.students});

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
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
          hmTxtLarge(text: "Student Detail"),
          SizedBox(
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
              SizedBox(
                height: 20,
              ),
              hmTxtMedium(text: widget.students.name!),
              SizedBox(
                height: 8,
              ),
              hmTxtMedium(text: "Age :${widget.students.age!}"),
              SizedBox(
                height: 8,
              ),
              hmTxtSmall(text: widget.students.email!)
            ],
          ),
          Expanded(
            child: SizedBox(),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
