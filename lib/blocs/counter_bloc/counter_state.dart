class CounterState {
  final int count;
  CounterState({required this.count});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(count: 0);
}
