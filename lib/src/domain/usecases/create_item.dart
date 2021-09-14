import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_item.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';

class CreateItem implements UserCase<Either<Failure, dynamic>, ArrayItem> {
  final ArrayBloc bloc;
  final DatabaseImpl database;

  CreateItem({
    required this.bloc,
    required this.database,
  });

  @override
  Future<Either<Failure, bool>> call(ArrayItem created) async {
    log('***** CreateItem call: id = ${created.id}');

    final databaseRequestResult = await database.createItem(created);
    databaseRequestResult.fold(
      (l) {
        log('***** CreateItem failure: ${l.message}');
      },
      (r) {
        bloc.add(ArrayItemCreate(
          item: created,
        ));
      },
    );

    return const Right(true);
  }
}
