class GithubRepo {
  final String name;
  final String description;
  final String url;
  final String? language;
  // final String? stars;

  GithubRepo({
    required this.name,
    required this.description,
    required this.url,
     this.language = "",
    // this.stars="",
  });
}
