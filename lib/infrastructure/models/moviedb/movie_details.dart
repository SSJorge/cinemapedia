class MovieDetails {
  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    final collectionJson = _asNullableMap(json["belongs_to_collection"]);

    return MovieDetails(
      adult: _asBool(json["adult"]),

      backdropPath: _asString(json["backdrop_path"]),

      belongsToCollection: collectionJson == null
          ? null
          : BelongsToCollection.fromJson(collectionJson),

      budget: _asInt(json["budget"]),

      genres: _asList(json["genres"])
          .map(_asNullableMap)
          .whereType<Map<String, dynamic>>()
          .map(Genre.fromJson)
          .toList(),

      homepage: _asString(json["homepage"]),

      id: _asInt(json["id"]),

      imdbId: _asString(json["imdb_id"]),

      originalLanguage: _asString(json["original_language"]),

      originalTitle: _asString(json["original_title"]),

      overview: _asString(json["overview"]),

      popularity: _asDouble(json["popularity"]),

      posterPath: _asNullableString(json["poster_path"]),

      productionCompanies: _asList(json["production_companies"])
          .map(_asNullableMap)
          .whereType<Map<String, dynamic>>()
          .map(ProductionCompany.fromJson)
          .toList(),

      productionCountries: _asList(json["production_countries"])
          .map(_asNullableMap)
          .whereType<Map<String, dynamic>>()
          .map(ProductionCountry.fromJson)
          .toList(),

      releaseDate: _asDateTime(json["release_date"], fallback: DateTime(1900)),

      revenue: _asInt(json["revenue"]),

      runtime: _asInt(json["runtime"]),

      spokenLanguages: _asList(json["spoken_languages"])
          .map(_asNullableMap)
          .whereType<Map<String, dynamic>>()
          .map(SpokenLanguage.fromJson)
          .toList(),

      status: _asString(json["status"]),

      tagline: _asString(json["tagline"]),

      title: _asString(json["title"], fallback: 'Título desconocido'),

      video: _asBool(json["video"]),

      voteAverage: _asDouble(json["vote_average"]),

      voteCount: _asInt(json["vote_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection?.toJson(),
    "budget": budget,
    "genres": genres.map((genre) => genre.toJson()).toList(),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": productionCompanies
        .map((company) => company.toJson())
        .toList(),
    "production_countries": productionCountries
        .map((country) => country.toJson())
        .toList(),
    "release_date": _dateToJson(releaseDate),
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": spokenLanguages
        .map((language) => language.toJson())
        .toList(),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class BelongsToCollection {
  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  final int id;
  final String name;

  // Son nullable porque TMDB puede enviarlos como null.
  final String? posterPath;
  final String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) {
    return BelongsToCollection(
      id: _asInt(json["id"]),
      name: _asString(json["name"]),
      posterPath: _asNullableString(json["poster_path"]),
      backdropPath: _asNullableString(json["backdrop_path"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "backdrop_path": backdropPath,
  };
}

class Genre {
  Genre({required this.id, required this.name});

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: _asInt(json["id"]), name: _asString(json["name"]));
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: _asInt(json["id"]),
      logoPath: _asNullableString(json["logo_path"]),
      name: _asString(json["name"]),
      originCountry: _asString(json["origin_country"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  ProductionCountry({required this.iso31661, required this.name});

  final String iso31661;
  final String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: _asString(json["iso_3166_1"]),
      name: _asString(json["name"]),
    );
  }

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: _asString(json["english_name"]),
      iso6391: _asString(json["iso_639_1"]),
      name: _asString(json["name"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}

/*
|--------------------------------------------------------------------------
| Funciones auxiliares para conversión segura
|--------------------------------------------------------------------------
*/

String _asString(dynamic value, {String fallback = ''}) {
  if (value == null) return fallback;

  if (value is String) {
    return value;
  }

  return value.toString();
}

String? _asNullableString(dynamic value) {
  if (value == null) return null;

  final stringValue = value.toString().trim();

  if (stringValue.isEmpty) {
    return null;
  }

  return stringValue;
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value == null) return fallback;

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString()) ?? fallback;
}

double _asDouble(dynamic value, {double fallback = 0.0}) {
  if (value == null) return fallback;

  if (value is double) {
    return value;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString()) ?? fallback;
}

bool _asBool(dynamic value, {bool fallback = false}) {
  if (value == null) return fallback;

  if (value is bool) {
    return value;
  }

  if (value is num) {
    return value != 0;
  }

  final normalizedValue = value.toString().trim().toLowerCase();

  if (normalizedValue == 'true' || normalizedValue == '1') {
    return true;
  }

  if (normalizedValue == 'false' || normalizedValue == '0') {
    return false;
  }

  return fallback;
}

List<dynamic> _asList(dynamic value) {
  if (value is List) {
    return value;
  }

  return const [];
}

Map<String, dynamic>? _asNullableMap(dynamic value) {
  if (value == null || value is! Map) {
    return null;
  }

  return value.map((key, mapValue) => MapEntry(key.toString(), mapValue));
}

DateTime _asDateTime(dynamic value, {required DateTime fallback}) {
  if (value == null) {
    return fallback;
  }

  if (value is DateTime) {
    return value;
  }

  final stringValue = value.toString().trim();

  if (stringValue.isEmpty) {
    return fallback;
  }

  return DateTime.tryParse(stringValue) ?? fallback;
}

String _dateToJson(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}
// class MovieDetails {
//   MovieDetails({
//     required this.adult,
//     required this.backdropPath,
//     required this.belongsToCollection,
//     required this.budget,
//     required this.genres,
//     required this.homepage,
//     required this.id,
//     required this.imdbId,
//     required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.productionCompanies,
//     required this.productionCountries,
//     required this.releaseDate,
//     required this.revenue,
//     required this.runtime,
//     required this.spokenLanguages,
//     required this.status,
//     required this.tagline,
//     required this.title,
//     required this.video,
//     required this.voteAverage,
//     required this.voteCount,
//   });

//   final bool adult;
//   final String backdropPath;
//   final BelongsToCollection? belongsToCollection;
//   final int budget;
//   final List<Genre> genres;
//   final String homepage;
//   final int id;
//   final String imdbId;
//   final String originalLanguage;
//   final String originalTitle;
//   final String overview;
//   final double popularity;
//   final String? posterPath;
//   final List<ProductionCompany> productionCompanies;
//   final List<ProductionCountry> productionCountries;
//   final DateTime releaseDate;
//   final int revenue;
//   final int runtime;
//   final List<SpokenLanguage> spokenLanguages;
//   final String status;
//   final String tagline;
//   final String title;
//   final bool video;
//   final double voteAverage;
//   final int voteCount;

//   factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
//     adult: json["adult"],
//     backdropPath: json["backdrop_path"] ?? '',
//     belongsToCollection: json["belongs_to_collection"] == null
//         ? null
//         : BelongsToCollection.fromJson(json["belongs_to_collection"]),
//     budget: json["budget"],
//     genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
//     homepage: json["homepage"],
//     id: json["id"],
//     imdbId: json["imdb_id"] ?? '',
//     originalLanguage: json["original_language"],
//     originalTitle: json["original_title"],
//     overview: json["overview"],
//     popularity: json["popularity"]?.toDouble(),
//     posterPath: json["poster_path"],
//     productionCompanies: List<ProductionCompany>.from(
//       json["production_companies"].map((x) => ProductionCompany.fromJson(x)),
//     ),
//     productionCountries: List<ProductionCountry>.from(
//       json["production_countries"].map((x) => ProductionCountry.fromJson(x)),
//     ),
//     releaseDate:
//         DateTime.tryParse(json["release_date"] ?? '') ?? DateTime(1900),
//     revenue: json["revenue"],
//     runtime: json["runtime"],
//     spokenLanguages: List<SpokenLanguage>.from(
//       json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x)),
//     ),
//     status: json["status"],
//     tagline: json["tagline"],
//     title: json["title"],
//     video: json["video"],
//     voteAverage: json["vote_average"]?.toDouble(),
//     voteCount: json["vote_count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "belongs_to_collection": belongsToCollection?.toJson(),
//     "budget": budget,
//     "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
//     "homepage": homepage,
//     "id": id,
//     "imdb_id": imdbId,
//     "original_language": originalLanguage,
//     "original_title": originalTitle,
//     "overview": overview,
//     "popularity": popularity,
//     "poster_path": posterPath,
//     "production_companies": List<dynamic>.from(
//       productionCompanies.map((x) => x.toJson()),
//     ),
//     "production_countries": List<dynamic>.from(
//       productionCountries.map((x) => x.toJson()),
//     ),
//     "release_date":
//         "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
//     "revenue": revenue,
//     "runtime": runtime,
//     "spoken_languages": List<dynamic>.from(
//       spokenLanguages.map((x) => x.toJson()),
//     ),
//     "status": status,
//     "tagline": tagline,
//     "title": title,
//     "video": video,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
// }

// class BelongsToCollection {
//   BelongsToCollection({
//     required this.id,
//     required this.name,
//     required this.posterPath,
//     required this.backdropPath,
//   });

//   final int id;
//   final String name;
//   final String posterPath;
//   final String backdropPath;

//   factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
//       BelongsToCollection(
//         id: json["id"],
//         name: json["name"],
//         posterPath: json["poster_path"],
//         backdropPath: json["backdrop_path"],
//       );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "poster_path": posterPath,
//     "backdrop_path": backdropPath,
//   };
// }

// class Genre {
//   Genre({required this.id, required this.name});

//   final int id;
//   final String name;

//   factory Genre.fromJson(Map<String, dynamic> json) =>
//       Genre(id: json["id"], name: json["name"]);

//   Map<String, dynamic> toJson() => {"id": id, "name": name};
// }

// class ProductionCompany {
//   ProductionCompany({
//     required this.id,
//     required this.logoPath,
//     required this.name,
//     required this.originCountry,
//   });

//   final int id;
//   final String? logoPath;
//   final String name;
//   final String originCountry;

//   factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
//       ProductionCompany(
//         id: json["id"],
//         logoPath: json["logo_path"],
//         name: json["name"],
//         originCountry: json["origin_country"],
//       );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "logo_path": logoPath,
//     "name": name,
//     "origin_country": originCountry,
//   };
// }

// class ProductionCountry {
//   ProductionCountry({required this.iso31661, required this.name});

//   final String iso31661;
//   final String name;

//   factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
//       ProductionCountry(iso31661: json["iso_3166_1"], name: json["name"]);

//   Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
// }

// class SpokenLanguage {
//   SpokenLanguage({
//     required this.englishName,
//     required this.iso6391,
//     required this.name,
//   });

//   final String englishName;
//   final String iso6391;
//   final String name;

//   factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
//     englishName: json["english_name"],
//     iso6391: json["iso_639_1"],
//     name: json["name"],
//   );

//   Map<String, dynamic> toJson() => {
//     "english_name": englishName,
//     "iso_639_1": iso6391,
//     "name": name,
//   };
// }
