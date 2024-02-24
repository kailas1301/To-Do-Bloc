import 'package:flutter/material.dart';
import 'package:todo/core/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.titleController,
    required this.title,
  }) : super(key: key);

  final TextEditingController titleController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 2, color: kVioletColor)),
        hintText: title,
      ),
    );
  }
}
