import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return; //si ya estoy cargando, no hago nada
    isLoading = true;
    print('Cargando siguientes peliculas en cartelera');
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [
      ...state,
      ...movies,
    ]; //voy s regresar el estado actual dcon todAS LAS peluis asi con el operador spread y luego le agrego las nuevas peluis que acabo de traer
    await Future.delayed(const Duration(seconds: 1)); //opcional
    isLoading = false;
  }
}
