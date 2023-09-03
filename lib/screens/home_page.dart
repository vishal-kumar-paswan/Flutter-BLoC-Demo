import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_event.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_state.dart';

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Counter'),
            elevation: 0.0,
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Count',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.count.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(IncrementCount());
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(DecrementCount());
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        );
      },
    );
  }
}
