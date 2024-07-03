

import 'github_repo.dart';

GithubRepo githubRepoFromJson(Map<String, dynamic> json, {String? language}) {
  return GithubRepo(
    name: json['name'],
    description: json['description'] ?? "",
    language: language,
    url: json['url'],
    // stars: json['stargazerCount'],
  );
}

GithubRepo githubRepoFromJsonLocal(Map<String, dynamic> json, {String? language}) {
  return GithubRepo(
      name: json['name'],
      description: json['description'] ?? "",
      language: json['language'],
      url: json['url'],
  );
}

Map<String, dynamic> githubRepoToJson(GithubRepo repo) {
  return {
    'name': repo.name,
    'description': repo.description,
    'language': repo.language,
    'url': repo.url,
  };
}
