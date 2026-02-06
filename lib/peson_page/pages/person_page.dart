import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:d_input/d_input.dart';
import 'package:riverpod_lesson/peson_page/models/person.dart';
import 'package:riverpod_lesson/peson_page/providers/person_provider.dart';

class PersonPage extends ConsumerWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build Page");
    final edtName = TextEditingController();
    final edtAge = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Person")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: DInput(
                  inputSpec: InputSpec(controller: edtName, hint: 'Name'),
                ),
              ),
              IconButton(onPressed: () {
                                ref.read(personNotifierProvider.notifier).updateName(edtName.text);
              }, icon: Icon(Icons.save)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DInput(
                  inputSpec: InputSpec(controller: edtAge, hint: 'Age'),
                ),
              ),
              IconButton(onPressed: () {
                ref.read(personNotifierProvider.notifier).updateAge(int.parse(edtAge.text));
              }, icon: Icon(Icons.save)),
            ],
          ),
          const SizedBox(height: 20),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              print("build name");
              String name = ref.watch(personNotifierProvider.select((person) => person.name));
              return Text("Name :$name");
            },
          ),
               Consumer(
            builder: (_, WidgetRef ref, __) {
              print("build age");
              int age = ref.watch(personNotifierProvider.select((person)=> person.age));
              return Text("Age :${age}");
            },
          ),
        ],
      ),
    );
  }
}
