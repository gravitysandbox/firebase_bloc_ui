import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';

class DeleteItem implements UserCase<Either<Failure, dynamic>, String> {
  final ArrayBloc bloc;
  final Database database;

  DeleteItem({
    required this.bloc,
    required this.database,
  });

  @override
  Future<Either<Failure, bool>> call(String id) async {
    log('***** DeleteItem call: id = $id');

    final databaseRequestResult = await database.deleteItem(id);
    databaseRequestResult.fold(
      (l) {
        log('***** DeleteItem failure: ${l.message}');
      },
      (r) {
        bloc.add(ArrayItemDelete(id: id));
      },
    );

    return const Right(true);
  }
}
