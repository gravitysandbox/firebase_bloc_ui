import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';

class UpdateItem implements UserCase<Either<Failure, dynamic>, ArrayItem> {
  final ArrayBloc bloc;

  UpdateItem({required this.bloc});

  @override
  Future<Either<Failure, dynamic>> call(ArrayItem updated) async {
    log('***** UpdateItem call: id = ${updated.id}');
    bloc.add(ArrayItemUpdate(
      item: updated,
    ));

    return Right(updated.id);
  }
}