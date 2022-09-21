import 'package:flutter/material.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
