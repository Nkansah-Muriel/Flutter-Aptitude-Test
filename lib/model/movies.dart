class Movies {
  final String title;
  final String backDropPath;
  final String date;
  final String overview;

  Movies({
    required this.title,
    required this.backDropPath,
    required this.date,
    required this.overview,
  });

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      title: map["title"],
      backDropPath: map['backdrop_path'],
      date: map['release_date'],
      overview: map['overview'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop_path': backDropPath,
      'release_date': date,
      'overview': overview,
    };
  }
}
