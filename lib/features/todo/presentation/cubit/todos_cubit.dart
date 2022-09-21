import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/create_todo_use_case.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todos_use_case.dart';

part 'todos_state.dart';

@Injectable()
class TodosCubit extends Cubit<TodosState> {
  final GetTodosUseCase _getTodosUseCase;
  final CreateTodoUseCase _createTodoUseCase;

  TodosCubit(this._getTodosUseCase, this._createTodoUseCase)
      : super(TodosInitial());

  Future<void> getTodos() async {
    emit(TodosLoading());
    final failureOrSuccess = await _getTodosUseCase(NoParams());
    emit(failureOrSuccess.fold(
      (failure) => TodosError(failure.toString()),
      (todos) => TodosLoaded(todos.reversed.toList()),
    ));
  }

  Future<void> createTodo({required String title}) async {
    final failureOrSuccess = await _createTodoUseCase(Params(title: title));
    emit(failureOrSuccess.fold(
      (failure) => TodosError(failure.toString()),
      (todo) {
        final currentState = state;
        if (currentState is TodosLoaded) {
          currentState.todos.add(todo);
          return TodosLoaded(List.of(currentState.todos.reversed.toList()));
        }
        return const TodosError("Error creating todo");
      },
    ));
  }
}
