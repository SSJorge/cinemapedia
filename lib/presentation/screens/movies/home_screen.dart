import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Center(child: Text(Environment.theMovieDbKey)));
    return Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //cuando se inicia el widget, se carga la primera pagina de peliculas en cartelera
  }

  @override
  Widget build(BuildContext context) {
    //no hacew falta poner el ref pq estoy en un consumerstate y ya tengo referencia al mismo

    //aqui es watch pq tengo q estar pendiente del estado q me va a proporcionar mi nowplayingmoviesprovider
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(title: Text(movie.title));
      },
    );
  }
}
