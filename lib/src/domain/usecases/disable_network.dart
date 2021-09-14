import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/network_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/network_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';

class DisableNetwork implements UserCase<Either<Failure, void>, NoParams> {
  final NetworkBloc bloc;

  DisableNetwork({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    log('***** DisableNetwork call');
    bloc.add(const NetworkDisable());

    return const Right(true);
  }
}
