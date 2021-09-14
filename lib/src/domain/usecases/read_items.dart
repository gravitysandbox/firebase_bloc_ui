import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';

class ReadItems implements UserCase<Either<Failure, void>, NoParams> {
  final ArrayBloc bloc;
  final DatabaseImpl database;

  ReadItems({
    required this.bloc,
    required this.database,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    log('***** ReadItems call');

    final databaseRequestResult = await database.readItems();
    databaseRequestResult.fold(
      (l) {
        log('***** ReadItems failure: ${l.message}');
      },
      (r) {
        bloc.add(ArrayItemRead(items: [...r]));
      },
    );

    return const Right(true);
  }
}
