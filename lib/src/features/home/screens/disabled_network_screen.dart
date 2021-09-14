import 'package:firebase_bloc_ui/src/features/shared/content_wrapper.dart';
import 'package:flutter/material.dart';

class DisabledNetworkScreen extends StatelessWidget {
  static const routeName = '/disabled';
  final String title;

  const DisabledNetworkScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(title),
      ),
      body: const ContentWrapper(
        widget: Center(
          child: Text('Connection lost'),
        ),
      ),
    );
  }
}
