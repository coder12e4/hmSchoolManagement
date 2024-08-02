import 'package:flutter/material.dart';

class hmTxtSmall extends StatelessWidget {
  final String text;
  const hmTxtSmall({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class hmTxtMedium extends StatelessWidget {
  final String text;
  const hmTxtMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class hmTxtLarge extends StatelessWidget {
  final String text;
  const hmTxtLarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class hmTxtExtralarge extends StatelessWidget {
  final String text;
  const hmTxtExtralarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}

class ExpTextField extends StatelessWidget {
  final String labal;
  final TextEditingController textEditingController;
  final bool ObsecuredText;
  final Icon icon;
  const ExpTextField(
      {super.key,
      required this.labal,
      required this.textEditingController,
      required this.ObsecuredText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: ObsecuredText,
      decoration: InputDecoration(suffixIcon: icon, label: Text(labal)),
    );
  }
}
