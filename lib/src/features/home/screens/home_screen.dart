import 'package:firebase_bloc_ui/locator.dart';
import 'package:firebase_bloc_ui/src/constants.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_item.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/create_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/delete_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/read_items.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/update_item.dart';
import 'package:firebase_bloc_ui/src/features/home/widgets/builder_appbar.dart';
import 'package:firebase_bloc_ui/src/features/home/widgets/create_dialog.dart';
import 'package:firebase_bloc_ui/src/features/home/widgets/items_builder.dart';
import 'package:firebase_bloc_ui/src/features/home/widgets/update_dialog.dart';
import 'package:firebase_bloc_ui/src/features/shared/content_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  final String title;

  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _readItemsHandler() {
    locator<ReadItems>().call(NoParams());
  }

  void _createItemHandler() async {
    final result = await showModalBottomSheet<ArrayItem>(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const CreateItemDialog();
      },
    );

    if (result != null) {
      locator<CreateItem>().call(result);
    }
  }

  void _updateItemHandler(ArrayItem oldItem) async {
    final result = await showModalBottomSheet<ArrayItem>(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateItemDialog(item: oldItem);
      },
    );

    if (result != null) {
      locator<UpdateItem>().call(result);
    }
  }

  void _deleteItemHandler(String id) {
    locator<DeleteItem>().call(id);
  }

  SnackBar _buildSnackBar(ArrayEventType event) {
    final Map<ArrayEventType, String> snackText = {
      ArrayEventType.create: 'Created',
      ArrayEventType.read: 'Read',
      ArrayEventType.update: 'Updated',
      ArrayEventType.delete: 'Deleted',
    };

    return SnackBar(
      content: Text(snackText[event]!),
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _readItemsHandler,
            padding: const EdgeInsets.all(8.0),
            splashRadius: kDefaultIconSize,
            icon: const Icon(
              Icons.refresh,
              size: kDefaultIconSize,
            ),
          ),
        ],
      ),
      body: BlocConsumer<ArrayBloc, ArrayState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_buildSnackBar(state.event));
        },
        builder: (context, state) {
          return ContentWrapper(
            widget: Center(
              child: Column(
                children: <Widget>[
                  BuilderAppbar(
                    callback: _createItemHandler,
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  state.items.isNotEmpty
                      ? ItemsBuilder(
                          items: state.items,
                          updateCallback: _updateItemHandler,
                          deleteCallback: _deleteItemHandler,
                        )
                      : const Text('Nothing to show'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
