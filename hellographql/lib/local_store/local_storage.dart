import 'dart:convert';
import 'package:hive/hive.dart';

import '../models/github_repo.dart';
import '../models/json_formater.dart';

abstract class LocalDataStorage {
  Future<void> savaRepo(GithubRepo repo);

  Future<List<GithubRepo>> getRepos();

  Future<void> clearCache();
}

class LocalDataStorageImpl implements LocalDataStorage {
  @override
  Future<void> savaRepo(GithubRepo repo) async {
    var repos = await Hive.openBox('gitHubRepo');
    repos.put(repo.name, jsonEncode(githubRepoToJson(repo)));
  }

  @override
  Future<List<GithubRepo>> getRepos() async {
    var repos = await Hive.openBox('gitHubRepo');
    final savedRepo = repos.values.toList();
    final loadedRepo = savedRepo
        .map((game) => githubRepoFromJsonLocal(jsonDecode(game)))
        .toList();
    return loadedRepo;
  }

  @override
  Future<void> clearCache() async {
    var repos = await Hive.openBox('gitHubRepo');
    repos.clear();
  }
}
