import 'package:flutter/material.dart';
import 'package:riverpod_lesson/counter/page/counter_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson/live_game/pages/live_game_page.dart';
import 'package:riverpod_lesson/home.dart';
import 'package:riverpod_lesson/peson_page/pages/person_page.dart';
import 'package:riverpod_lesson/todolist/pages/todo_page.dart';

void main(){
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        "/person_page": (context) => const PersonPage(),
      }
    );
  }
}
