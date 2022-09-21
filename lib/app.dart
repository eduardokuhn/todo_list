import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/cubit/todos_cubit.dart';
import 'package:todo_list/features/todo/presentation/screens/home_screen.dart';
import 'package:todo_list/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<TodosCubit>(),
      child: MaterialApp(
        title: 'ToDo List Eduardo Kuhn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
