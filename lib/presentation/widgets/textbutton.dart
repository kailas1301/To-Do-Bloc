import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.onPressedName,
    required this.onPressed,
  }) : super(key: key);

  final String onPressedName;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(onPressedName),
    );
  }
}
