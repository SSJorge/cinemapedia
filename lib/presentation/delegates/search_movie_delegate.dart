import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

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
    if (query.trim().isEmpty) {
      return const Center(child: Text('Escribe el nombre de una película'));
    }

    return FutureBuilder<List<Movie>>(
      future: searchMovies(query.trim()),
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
            return _MovieItem(movie: movies[index]);
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
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
    );
  }
}
