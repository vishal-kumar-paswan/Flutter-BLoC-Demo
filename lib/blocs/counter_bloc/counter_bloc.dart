import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_event.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on<IncrementCount>(
      (event, emit) => emit(CounterState(count: state.count + 1)),
    );
    on<DecrementCount>(
      (event, emit) => emit(CounterState(count: state.count - 1)),
    );
  }
}
