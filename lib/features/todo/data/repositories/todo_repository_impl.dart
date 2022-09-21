import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/error/exception.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/features/todo/data/datasources/json_placeholder_api_impl.dart';
import 'package:todo_list/features/todo/data/models/todo_model.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/itodo_repository.dart';

@Singleton(as: ITodoRepository)
class TodoRepositoryImpl implements ITodoRepository {
  final IJsonPlaceholderApi _jsonPlaceholderApi;

  TodoRepositoryImpl(this._jsonPlaceholderApi);

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      return Right(await _jsonPlaceholderApi.getTodos());
    } on ServerException {
      return Left(ServerFailure());
    } on InternetException {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> createTodo({required String title}) async {
    try {
      final todoModel = TodoModel(userId: 100, title: title, completed: false);
      return Right(await _jsonPlaceholderApi.createTodo(todoModel: todoModel));
    } on ServerException {
      return Left(ServerFailure());
    } on InternetException {
      return Left(InternetFailure());
    }
  }
}
