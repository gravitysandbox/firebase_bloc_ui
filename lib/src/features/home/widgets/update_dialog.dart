import 'package:firebase_bloc_ui/src/constants.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/features/shared/content_wrapper.dart';
import 'package:firebase_bloc_ui/src/features/shared/input_field.dart';
import 'package:firebase_bloc_ui/src/features/shared/primary_button.dart';
import 'package:flutter/material.dart';

class UpdateItemDialog extends StatefulWidget {
  final ArrayItem item;

  const UpdateItemDialog({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<UpdateItemDialog> createState() => _UpdateItemDialogState();
}

class _UpdateItemDialogState extends State<UpdateItemDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title);
    _subtitleController = TextEditingController(text: widget.item.subtitle);

    _titleController.addListener(_checkButtonDisability);
    _subtitleController.addListener(_checkButtonDisability);
  }

  @override
  void dispose() {


    _titleController.removeListener(_checkButtonDisability);
    _subtitleController.removeListener(_checkButtonDisability);
    super.dispose();
  }

  void _checkButtonDisability() {
    final isDisabled =
        _titleController.text.isEmpty || _subtitleController.text.isEmpty;

    if (_isButtonDisabled != isDisabled) {
      setState(() {
        _isButtonDisabled = isDisabled;
      });
    }
  }

  void _onCreateButtonHandler() {
    Navigator.of(context).pop<ArrayItem>(ArrayItem(
      id: widget.item.id,
      title: _titleController.text,
      subtitle: _subtitleController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          kDefaultPadding,
          kDefaultPadding,
          kDefaultPadding,
          kDefaultPadding + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ContentWrapper(
          widget: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InputField(
                  controller: _titleController,
                  hintText: 'Title',
                  labelText: 'Your title',
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                InputField(
                  controller: _subtitleController,
                  hintText: 'Subtitle',
                  labelText: 'Your subtitle',
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                PrimaryButton(
                  label: 'Update',
                  isDisabled: _isButtonDisabled,
                  callback: _onCreateButtonHandler,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
