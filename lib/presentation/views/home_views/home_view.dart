import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref
        .read(topRatedMoviesProvider.notifier)
        .loadNextPage(); //cuando se inicia el widget, se carga la primera pagina de peliculas en cartelera
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) {
      return const FullScreenLoader(); //si esta cargando, muestra el loader
    }
    //no hacew falta poner el ref pq estoy en un consumerstate y ya tengo referencia al mismo

    //aqui es watch pq tengo q estar pendiente del estado q me va a proporcionar mi nowplayingmoviesprovider
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    if (slideShowMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // return SingleChildScrollView(
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                CustomAppbar(),

                // Expanded(
                //   //dado el padre expanda todo lo posible
                //   child: ListView.builder(
                //     itemCount: nowPlayingMovies.length,
                //     itemBuilder: (context, index) {
                //       final movie = nowPlayingMovies[index];
                //       return ListTile(title: Text(movie.title));
                //     },
                //   ),
                // ),
                MoviesSlideshow(movies: slideShowMovies),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    //read no watch, read dentro de funciones o callback como este
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Pronto en cines',
                  subTitle: 'En este mes',
                  loadNextPage: () {
                    //read no watch, read dentro de funciones o callback como este
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Propulares',
                  // subTitle: '',
                  loadNextPage: () {
                    //read no watch, read dentro de funciones o callback como este
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: () {
                    //read no watch, read dentro de funciones o callback como este
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
