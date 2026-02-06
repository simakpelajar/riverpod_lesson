import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_image/extended_image.dart';
import 'package:riverpod_lesson/live_game/models/game.dart';
import 'package:riverpod_lesson/live_game/providers/genre_provider.dart';
import 'package:riverpod_lesson/live_game/providers/live_game_provider.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage> {
  List<String> genres = ['Shooter', 'MMOARPG', 'ARPG', 'Strategy', 'Fighting'];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(liveGameNotifierProvider.notifier).fetchLiveGame(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Game")),
      body: Column(
        children: [
          Consumer(
            builder: (context, wiRef, child) {
              String genreSelected = wiRef.watch(genreNotifierProvider);
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: genres.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActionChip(
                        onPressed: () {
                          wiRef.read(genreNotifierProvider.notifier).change(e);
                        },
                        label: Text(
                          e,
                          style: TextStyle(
                            color: genreSelected == e
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                        backgroundColor: genreSelected == e
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(liveGameNotifierProvider);
                final selectedGenre = ref.watch(genreNotifierProvider);
                return _buildBody(state, selectedGenre);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(LiveGameState state, String genre) {
    if (state.status == '') {
      return const SizedBox.shrink();
    }

    if (state.status == 'loading') {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == 'failed') {
      return Center(child: Text(state.message));
    }

    final filterGames = state.data
        .where((state) => state.genre == genre)
        .toList();
    if (filterGames.isEmpty) {
      return const Center(child: Text('No games found'));
    }
    return GridView.builder(
      itemCount: filterGames.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        Game game = filterGames[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ExtendedImage.network(game.thumbnail!, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          ref
                              .read(liveGameNotifierProvider.notifier)
                              .changeIsSaved(
                                game.copyWith(isSaved: !game.isSaved),
                              );
                        },
                        icon: game.isSaved
                            ? const Icon(Icons.bookmark, color: Colors.amber)
                            : const Icon(
                                Icons.bookmark_border,
                                color: Colors.blue,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
