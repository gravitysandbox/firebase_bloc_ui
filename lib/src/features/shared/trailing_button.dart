import 'package:firebase_bloc_ui/src/constants.dart';
import 'package:flutter/material.dart';

class TrailingButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback callback;

  const TrailingButton({
    Key? key,
    required this.iconData,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          size: kDefaultIconSize,
        ),
      ),
    );
  }
}
