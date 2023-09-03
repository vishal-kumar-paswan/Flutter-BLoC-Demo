import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_bloc_counter/screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => CounterBloc(),
      child: const MaterialApp(
        home: CounterHomePage(),
      ),
    );
  }
}


