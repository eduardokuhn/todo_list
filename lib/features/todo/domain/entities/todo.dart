import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  Todo({required this.userId, required this.title, required this.completed});

  final int userId;
  int? id;
  final String title;
  bool completed;

  @override
  List<Object?> get props => [userId, id, title, completed];
}
