import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWykHx-KmnfCYBWxSrfZ3SntZD242DHX-x8A&s',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath?.isEmpty ?? false)
        ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWykHx-KmnfCYBWxSrfZ3SntZD242DHX-x8A&s',
    // releaseDate: DateTime.tryParse(moviedb.releaseDate) ?? DateTime(1900),
    releaseDate: moviedb.releaseDate != null
        ? moviedb.releaseDate!
        : DateTime(1900),
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage / 2, // Convertir a escala de 5
    voteCount: moviedb.voteCount,
  );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWykHx-KmnfCYBWxSrfZ3SntZD242DHX-x8A&s',
    genreIds: moviedb.genres.map((e) => e.name).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != '')
        ? 'http://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWykHx-KmnfCYBWxSrfZ3SntZD242DHX-x8A&s',
    // releaseDate: DateTime.tryParse(moviedb.releaseDate) ?? DateTime(1900),
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage / 2, // Convertir a escala de 5
    voteCount: moviedb.voteCount,
  );
}
