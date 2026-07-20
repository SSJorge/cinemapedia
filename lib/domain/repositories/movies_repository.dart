import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovies(String query);
}

//nuestros origenes de datos son los datasource y los repos son quienes van a llamar al datasource
//llamamos al datasource a traves del repo pq el repo es el q me apermitir a mi cambiar el datasource
// por ej quiero moviedb, ibmdb, de cualquier lugar podremos cambiar el origenes de datos facilmente
