import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';

class DeleteItem implements UserCase<Either<Failure, dynamic>, String> {
  final ArrayBloc bloc;

  DeleteItem({required this.bloc});

  @override
  Future<Either<Failure, dynamic>> call(String id) async {
    log('***** DeleteItem call: id = $id');
    bloc.add(ArrayItemDelete(id: id));

    return Right(id);
  }
}