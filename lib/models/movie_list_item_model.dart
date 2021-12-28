class MovieListItemModel {
  final List<SearchModel>? search;
  final String? totalResults;
  final String? response;
  MovieListItemModel({
    this.search,
    this.totalResults,
    this.response,
  });

  factory MovieListItemModel.fromJson(Map<String, dynamic> json) =>
      MovieListItemModel(
        search: json["Response"] == 'False'
            ? []
            : List<SearchModel>.from(
                json["Search"].map((x) => SearchModel.fromJson(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Search": List<dynamic>.from(search!.map((x) => x.toJson())),
        "totalResults": totalResults,
        "Response": response,
      };
}

class SearchModel {
  final String? title;
  final String? year;
  final String? imdbId;
  final String? type;
  final String? poster;
  SearchModel({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: json['type'],
        poster: json["Poster"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        // "Type": typeValues.reverse[type],
        "Poster": poster,
      };
}
