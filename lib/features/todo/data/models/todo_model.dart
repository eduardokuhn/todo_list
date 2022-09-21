import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Todo {
  TodoModel(
      {required super.userId, required super.title, required super.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
