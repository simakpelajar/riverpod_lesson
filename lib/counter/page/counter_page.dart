import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson/counter/provider/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Build Page");
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, wiRef, child) {
            debugPrint("Build text Counter");
            int counter = wiRef.watch(counterNotifierProvider);
            return Text("$counter");
          },
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).decrement();
            },
          ),
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).increment();
            },
          ),
        ],
      ),
    );
  }
}
