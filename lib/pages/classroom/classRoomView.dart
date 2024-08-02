import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class classRoomView extends StatefulWidget {
  const classRoomView({super.key});

  @override
  State<classRoomView> createState() => _classRoomViewState();
}

class _classRoomViewState extends State<classRoomView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
    );
  }
}
