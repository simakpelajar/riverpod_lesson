import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_lesson/peson_page/models/person.dart';

part 'person_provider.g.dart';

@riverpod
class PersonNotifier extends _$PersonNotifier {
  @override
  Person build() => Person('', 0);

  updateName(String n) => state = state.copyWith(name: n);
  updateAge(int n) => state = state.copyWith(age: n);
}
