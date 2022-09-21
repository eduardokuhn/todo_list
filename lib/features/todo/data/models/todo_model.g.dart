// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      userId: json['userId'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    )..id = json['id'] as int?;

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
