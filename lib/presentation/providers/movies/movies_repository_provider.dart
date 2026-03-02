//MOVIEREPO nuestro provider encargardo para  proveer ese repo, provider es el que provee la info
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este repositorio es inmutable, su obj es propocionrar a todos los demas proviers
// q tengo ahi adentro la info necesaria para que puedan consultar la info de este repositoryimpl

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
