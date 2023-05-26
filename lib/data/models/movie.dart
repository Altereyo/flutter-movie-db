class Movie {
  final String? id;
  final String? rank;
  final String? title;
  final String? fullTitle;
  final String? year;
  final String? image;
  final String? crew;
  final String? imDbRating;
  final String? description;

//<editor-fold desc="Data Methods">
  const Movie({
    this.id,
    this.rank,
    this.title,
    this.fullTitle,
    this.year,
    this.image,
    this.crew,
    this.imDbRating,
    this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rank == other.rank &&
          title == other.title &&
          fullTitle == other.fullTitle &&
          year == other.year &&
          image == other.image &&
          crew == other.crew &&
          imDbRating == other.imDbRating &&
          description == other.description);

  @override
  int get hashCode =>
      id.hashCode ^
      rank.hashCode ^
      title.hashCode ^
      fullTitle.hashCode ^
      year.hashCode ^
      image.hashCode ^
      crew.hashCode ^
      imDbRating.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'Movie{ id: $id, rank: $rank, title: $title, fullTitle: $fullTitle, year: $year, image: $image, crew: $crew, imDbRating: $imDbRating, description: $description,}';
  }

  Movie copyWith({
    String? id,
    String? rank,
    String? title,
    String? fullTitle,
    String? year,
    String? image,
    String? crew,
    String? imDbRating,
    String? description,
  }) {
    return Movie(
      id: id ?? this.id,
      rank: rank ?? this.rank,
      title: title ?? this.title,
      fullTitle: fullTitle ?? this.fullTitle,
      year: year ?? this.year,
      image: image ?? this.image,
      crew: crew ?? this.crew,
      imDbRating: imDbRating ?? this.imDbRating,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rank': rank,
      'title': title,
      'fullTitle': fullTitle,
      'year': year,
      'image': image,
      'crew': crew,
      'imDbRating': imDbRating,
      'description': description,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as String?,
      rank: map['rank'] as String?,
      title: map['title'] as String?,
      fullTitle: map['fullTitle'] as String?,
      year: map['year'] as String?,
      image: map['image'] as String?,
      crew: map['crew'] as String?,
      imDbRating: map['imDbRating'] as String?,
      description: map['description'] as String?,
    );
  }

//</editor-fold>
}
