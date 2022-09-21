import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/error/exception.dart';
import 'package:todo_list/features/todo/data/models/todo_model.dart';
import 'package:todo_list/features/todo/data/services/network_service_impl.dart';

abstract class IJsonPlaceholderApi {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> createTodo({required TodoModel todoModel});
}

@Singleton(as: IJsonPlaceholderApi)
class JsonPlaceholderApiImpl implements IJsonPlaceholderApi {
  final Dio _dio;
  final INetworkService _networkService;

  final String _baseUrl = 'https://jsonplaceholder.typicode.com/';

  JsonPlaceholderApiImpl(this._dio, this._networkService);

  @override
  Future<List<TodoModel>> getTodos() async {
    if (_networkService.networkStatus == NetworkStatus.online) {
      try {
        final request = '${_baseUrl}todos';

        final resp = await _dio.get(request);

        final todos = resp.data as List;

        return todos.map<TodoModel>((e) => TodoModel.fromJson(e)).toList();
      } on DioError catch (e) {
        debugPrint("JsonPlaceholderApiImpl.getTodos => $e");
        throw ServerException();
      } on FormatException catch (e) {
        debugPrint("JsonPlaceholderApiImpl.getTodos => $e");
        throw ServerException();
      }
    } else {
      throw InternetException();
    }
  }

  @override
  Future<TodoModel> createTodo({required TodoModel todoModel}) async {
    if (_networkService.networkStatus == NetworkStatus.online) {
      try {
        final request = '${_baseUrl}todos';

        final resp = await _dio.post(request, data: todoModel.toJson());

        return TodoModel.fromJson(resp.data);
      } on DioError catch (e) {
        debugPrint("JsonPlaceholderApiImpl.getTodos => $e");
        throw ServerException();
      }
    } else {
      throw InternetException();
    }
  }
}
