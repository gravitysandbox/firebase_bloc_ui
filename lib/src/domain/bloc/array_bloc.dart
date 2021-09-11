import 'dart:developer';

import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArrayBloc extends Bloc<ArrayEvent, ArrayState> {
  ArrayBloc(ArrayState initialState) : super(initialState);

  @override
  Stream<ArrayState> mapEventToState(ArrayEvent event) async* {
    log('***** ArrayBloc mapEventToState: ${event.runtimeType}');
    switch (event.runtimeType) {
      case ArrayItemCreate: {
        var snapshot = event as ArrayItemCreate;
        yield state.createElement(snapshot.item);
        break;
      }

      case ArrayItemRead: {
        var snapshot = event as ArrayItemRead;
        yield state.readElements(snapshot.items);
        break;
      }

      case ArrayItemUpdate: {
        var snapshot = event as ArrayItemUpdate;
        yield state.updateElement(snapshot.item);
        break;
      }

      case ArrayItemDelete: {
        var snapshot = event as ArrayItemDelete;
        yield state.deleteElement(snapshot.id);
        break;
      }
    }
  }
}