
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'genre_provider.g.dart';

@riverpod
class GenreNotifier extends _$GenreNotifier{

  @override
  String build() => 'Shooter';

  void change(String n) => state = n;
}