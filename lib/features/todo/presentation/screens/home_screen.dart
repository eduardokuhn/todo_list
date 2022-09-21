import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/cubit/todos_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<TodosCubit>(context).getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List Eduardo Kuhn'),
      ),
      body: SafeArea(
        child: BlocBuilder<TodosCubit, TodosState>(
          builder: (context, state) {
            if (state is TodosInitial) {
              return Center(child: Container());
            }

            if (state is TodosLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TodosLoaded) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: Text("${state.todos[index].id}"),
                    title: Text(state.todos[index].title),
                    trailing: Checkbox(
                      value: state.todos[index].completed,
                      onChanged: (value) {},
                    ),
                  );
                },
              );
            }

            if (state is TodosError) {
              return const Center(child: Text("Error trying to load todos"));
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CreateTodoBottomSheet();
            },
          )
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateTodoBottomSheet extends StatelessWidget {
  final _textEditingController = TextEditingController();

  CreateTodoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('Create ToDo'),
          const SizedBox(height: 20),
          TextField(
            autofocus: true,
            controller: _textEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Title',
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => BlocProvider.of<TodosCubit>(context)
                .createTodo(title: _textEditingController.text),
            child: const Text("Create"),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
