import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;

  const InputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 70.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
