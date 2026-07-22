import 'package:cinemapedia/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: textStyles),

              Spacer(),

              IconButton(
                onPressed: () {
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                    //puedo poner query: 'antman' y estara predefinido
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      // searchMovies: movieRepository.searchMovies,
                      // searchMovies: (query) {
                      //   ref
                      //       .read(searchQueryProvider.notifier)
                      //       .update((state) => query);
                      //   return movieRepository.searchMovies(query);
                      // },
                      searchMovies: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  ).then((movie) {
                    if (movie == null) return;
                    if (context.mounted) {
                      context.push('/movie/${movie.id}');
                    }
                  });
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
