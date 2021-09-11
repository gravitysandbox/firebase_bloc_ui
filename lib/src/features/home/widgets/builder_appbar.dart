import 'package:firebase_bloc_ui/src/features/shared/trailing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuilderAppbar extends StatelessWidget {
  final VoidCallback callback;

  const BuilderAppbar({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'List of nothing',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TrailingButton(
            iconData: Icons.add,
            callback: callback,
          ),
        ],
      ),
    );
  }
}
