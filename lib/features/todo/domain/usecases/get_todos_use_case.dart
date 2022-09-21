import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/itodo_repository.dart';

@Injectable()
class GetTodosUseCase extends UseCase<List<Todo>, NoParams> {
  final ITodoRepository repository;

  GetTodosUseCase(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
