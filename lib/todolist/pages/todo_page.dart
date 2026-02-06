import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson/todolist/models/todo.dart';
import 'package:riverpod_lesson/todolist/providers/todo_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildAdd(),
        child: const Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, wiRef, child) {
          List<Todo> todos = wiRef.watch(todoNotifierProvider);
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              return ListTile(
                leading: IconButton.filledTonal(
                  onPressed: () {
                    ref.read(todoNotifierProvider.notifier).update(todo);
                  },
                  icon: Icon(Icons.edit),
                ),
                title: Text(todo.title),
                subtitle: Text(todo.body),
                trailing: IconButton(
                  onPressed: () {
                    wiRef.read(todoNotifierProvider.notifier).remove(todo.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void buildAdd() {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Judul Todo"
            ),
            controller: edtTitle),
          SizedBox(height: 40,),
          TextField(
            decoration: InputDecoration(
              hintText: "Body Todo"
            ),
            controller: edtBody),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(todoNotifierProvider.notifier)
                  .add(edtTitle.text, edtBody.text);
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
