import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/itodo_repository.dart';

@Injectable()
class CreateTodoUseCase extends UseCase<Todo, Params> {
  final ITodoRepository repository;

  CreateTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params params) async {
    return await repository.createTodo(title: params.title);
  }
}

class Params extends Equatable {
  final String title;

  const Params({required this.title});

  @override
  List<Object?> get props => [title];
}
