import 'package:firebase_bloc_ui/src/models/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent {
  increment,
  decrement,
  error,
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(value: 0, wasIncremented: false));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        {
          yield CounterState(
            value: state.value + 1,
            wasIncremented: true,
          );
          break;
        }

      case CounterEvent.decrement:
        {
          yield CounterState(
            value: state.value - 1,
            wasIncremented: false,
          );
          break;
        }

      case CounterEvent.error:
        {
          addError(Exception('Unsupported event'));
          break;
        }
    }
  }
}
