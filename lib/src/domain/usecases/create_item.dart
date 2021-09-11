import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';

class CreateItem implements UserCase<Either<Failure, dynamic>, ArrayItem> {
  final ArrayBloc bloc;

  CreateItem({required this.bloc});

  @override
  Future<Either<Failure, dynamic>> call(ArrayItem created) async {
    log('***** CreateItem call: id = ${created.id}');
    bloc.add(ArrayItemCreate(
      item: created,
    ));

    return Right(created.id);
  }
}