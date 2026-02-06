import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_lesson/todolist/models/todo.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() => <Todo>[];

  void add(String title, String body) {
    Todo newTodo = Todo(id: const Uuid().v4(), title: title, body: body);
    //state.add(newTodo); // kalau pakai ini jadinya dia nanti gak bisa rebuild soalnya imutable state, makanya pakai state yang baru 
    state = [...state, newTodo];
  }

  void update(Todo newTodo){
    int index = state.indexWhere((e) => e.id == newTodo.id);
    state[index] = newTodo;
    state = [...state];
  }

  void remove(String id){
    state.removeWhere((e)=> e.id == id);
    state = [...state];
  }
}
