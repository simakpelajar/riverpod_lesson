// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_lesson/live_game/models/game.dart';
import 'package:riverpod_lesson/live_game/source/game_source.dart';

part 'live_game_provider.g.dart';

@riverpod
class LiveGameNotifier extends _$LiveGameNotifier{

  @override
  LiveGameState build() =>  LiveGameState(status: '', message: '', data: []);

  void fetchLiveGame() async {
    state = LiveGameState(status: 'loading', message: '', data: []);
    await Future.delayed(const Duration(seconds: 2));

    final games = await GameSource.getLive();
    if (games == null) {
         state = LiveGameState(status: 'failed', message: 'Something loaded data', data: []);
    } else {
          state = LiveGameState(status: 'succes', message: '', data: games);
    }

  }

   void changeIsSaved(Game newGame){
    int index = state.data.indexWhere((e)=> e.id == newGame.id);
     state.data[index] = newGame ;
        state = LiveGameState(status: 'succes', message: '', data: [...state.data]);

   }
}

class LiveGameState extends Equatable {
  final String status;
  final String message;
  final List<Game> data;

  LiveGameState({required this.status, required this.message, required this.data});

  @override
  List<Object> get props => [status, message, data];
}
