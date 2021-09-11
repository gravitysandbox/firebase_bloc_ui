import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final bool isDisabled;
  final VoidCallback callback;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.isDisabled,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.all(20.0),
        elevation: 1.0,
      ),
      onPressed: isDisabled ? null : callback,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}
