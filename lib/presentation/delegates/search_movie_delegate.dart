import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  // sin el broadcast solo va a poder tener un listener(alguna func q este escuchando el mismo) y pueden ser
  //varios lugares donde se este escuchando ese string, a pesar de q solo va a ser uno, pero cada vez q vaya al
  // onMovieSelected(context, movie) y se redibuje esto nuevamente va crear el streamcontroller,
  //o bueno, va a volverse a suscribir, entonces por eso tiene q ser un broadcast
  //si sè q solo hay un widget escuchandolo puede ser un streamcontroller normal, sino sè mejor poner broadcast
  Timer?
  _debounceTimer; //opcional? porq no quiero definirlo hasta q ya lo esté utilizando
  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    } //el timer cancelalo ya no sigas

    // El texto vacío debe guardarse inmediatamente
    if (query.trim().isEmpty) {
      searchMovies('');
      debouncedMovies.add([]);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return; //no quiero hacer una busqueda http si el query está vacio
      }

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  void clearStreams() {
    debouncedMovies.close();
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: Text('BuildResults'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    if (query.trim().isEmpty) {
      return const Center(child: Text('Escribe el nombre de una película'));
    }

    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint('Error buscando películas: ${snapshot.error}');
          debugPrintStack(stackTrace: snapshot.stackTrace);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Ocurrió un error al buscar películas:\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(child: Text('No se encontraron películas'));
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                //basta con onmmovieselect: close (al comienzo, antes del clearstream)
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.2,
                  height: 120,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(
                      'Error cargando póster de ${movie.title}: '
                      '${movie.posterPath}\n$error',
                    );

                    return const SizedBox(
                      height: 120,
                      child: Center(
                        child: Icon(Icons.broken_image_outlined, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium, maxLines: 2),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expanded( CHATGPT RECOMENDACION
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         movie.title,
            //         style: textStyles.titleMedium,
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),

            //       const SizedBox(height: 5),

            //       Text(
            //         movie.overview,
            //         style: textStyles.bodySmall,
            //         maxLines: 4,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
