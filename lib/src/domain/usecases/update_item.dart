import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_item.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';

class UpdateItem implements UserCase<Either<Failure, dynamic>, ArrayItem> {
  final ArrayBloc bloc;
  final Database database;

  UpdateItem({
    required this.bloc,
    required this.database,
  });

  @override
  Future<Either<Failure, bool>> call(ArrayItem updated) async {
    log('***** UpdateItem call: id = ${updated.id}');

    final databaseRequestResult = await database.updateItem(updated);
    databaseRequestResult.fold(
      (l) {
        log('***** UpdateItem failure: ${l.message}');
      },
      (r) {
        bloc.add(ArrayItemUpdate(
          item: updated,
        ));
      },
    );

    return const Right(true);
  }
}
