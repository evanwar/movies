class Movies {
  List<Movie> items = [];

  Movies();
  Movies.fromJsonList(List<dynamic> list) {
    if (list == null) return;

    for (var item in list) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  String uniqueId;
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Movie({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
  }

  getPoster() {
    if (posterPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    }
    return 'https://www.themoviedb.org/t/p/w500/$posterPath';
  }

  getBackGround() {
    if (posterPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    }
    return 'https://www.themoviedb.org/t/p/w500/$backdropPath';
  }
}
