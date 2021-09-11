import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/data.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';

class ReadItems implements UserCase<Either<Failure, dynamic>, NoParams> {
  final ArrayBloc bloc;

  ReadItems({required this.bloc});

  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    log('***** ReadItems call: length = ${demo_array.length}');
    bloc.add(ArrayItemRead(items: [...demo_array]));

    return Right(params);
  }
}