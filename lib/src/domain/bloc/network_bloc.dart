import 'dart:developer';

import 'package:firebase_bloc_ui/src/domain/events/network_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkBloc extends Bloc<NetworkEvent, bool> {
  NetworkBloc(bool initialState) : super(initialState);

  @override
  Stream<bool> mapEventToState(NetworkEvent event) async* {
    log('***** NetworkBloc mapEventToState: ${event.runtimeType}');
    switch (event.runtimeType) {
      case NetworkEnable: {
        yield true;
        break;
      }

      case NetworkDisable: {
        yield false;
        break;
      }
    }
  }
}