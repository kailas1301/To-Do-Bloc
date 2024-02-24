// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/to_do_bloc.dart';
import 'package:todo/domain/todo_api_functions.dart';
import 'package:todo/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(ToDoApiHelper()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        home: HomePage(),
      ),
    );
  }
}
