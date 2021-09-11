import 'dart:math';

import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/features/shared/trailing_button.dart';
import 'package:flutter/material.dart';

class ItemsBuilder extends StatelessWidget {
  final List<ArrayItem> items;
  final Function updateCallback;
  final Function deleteCallback;

  const ItemsBuilder({
    Key? key,
    required this.items,
    required this.updateCallback,
    required this.deleteCallback,
  }) : super(key: key);

  Widget _getCircleAvatar() {
    return CircleAvatar(
      radius: 20.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
        ),
      ),
    );
  }

  Widget _getButtonBar(ArrayItem item) {
    return SizedBox(
      width: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TrailingButton(
            iconData: Icons.edit,
            callback: () => updateCallback(item),
          ),
          TrailingButton(
            iconData: Icons.delete_forever,
            callback: () => deleteCallback(item.id),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1.0,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].title),
          subtitle: Text(items[index].subtitle),
          leading: _getCircleAvatar(),
          trailing: _getButtonBar(items[index]),
        );
      },
    );
  }
}
