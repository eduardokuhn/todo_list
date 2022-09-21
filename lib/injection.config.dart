// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/injectable/app_module.dart' as _i11;
import 'features/todo/data/datasources/json_placeholder_api_impl.dart' as _i5;
import 'features/todo/data/repositories/todo_repository_impl.dart' as _i7;
import 'features/todo/data/services/network_service_impl.dart' as _i4;
import 'features/todo/domain/repositories/itodo_repository.dart' as _i6;
import 'features/todo/domain/usecases/create_todo_use_case.dart' as _i8;
import 'features/todo/domain/usecases/get_todos_use_case.dart' as _i9;
import 'features/todo/presentation/cubit/todos_cubit.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(appModule.dio);
  gh.singleton<_i4.INetworkService>(_i4.NetworkServiceImpl());
  gh.singleton<_i5.IJsonPlaceholderApi>(_i5.JsonPlaceholderApiImpl(
    get<_i3.Dio>(),
    get<_i4.INetworkService>(),
  ));
  gh.singleton<_i6.ITodoRepository>(
      _i7.TodoRepositoryImpl(get<_i5.IJsonPlaceholderApi>()));
  gh.factory<_i8.CreateTodoUseCase>(
      () => _i8.CreateTodoUseCase(get<_i6.ITodoRepository>()));
  gh.factory<_i9.GetTodosUseCase>(
      () => _i9.GetTodosUseCase(get<_i6.ITodoRepository>()));
  gh.factory<_i10.TodosCubit>(() => _i10.TodosCubit(
        get<_i9.GetTodosUseCase>(),
        get<_i8.CreateTodoUseCase>(),
      ));
  return get;
}

class _$AppModule extends _i11.AppModule {}
