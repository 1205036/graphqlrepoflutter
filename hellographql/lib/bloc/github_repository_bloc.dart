import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../local_store/local_storage.dart';
import '../models/github_repo.dart';
import '../models/json_formater.dart';
import '../network/graph_result.dart';
import '../repositories/repository.dart';

part 'github_repository_event.dart';

part 'github_repository_state.dart';

class GithubRepositoryBloc extends Bloc<GithubRepositoryEvent, GithubRepositoryState> {
  final LocalDataStorage localDataStorage = LocalDataStorageImpl();
  final GitHubRepository gitHubRepository = GitHubRepository();

  GithubRepositoryBloc() : super(GithubRepositoryInitial()) {
    on<ClearCache>((event, emit) async {
      final localRepos = await localDataStorage.getRepos();

      if (localRepos.isNotEmpty) {

        await localDataStorage.clearCache();
        emit(const GithubRepositorySuccess(githubRepoList: []));
      }
    });

    on<FetchTrendingRepository>((event, emit) async {
      try {
        if (event.language == "All Language") {


          emit(GithubRepositoryInProgress());
          final localRepos = await localDataStorage.getRepos();

          if (localRepos.isNotEmpty) {
            emit(GithubRepositorySuccess(githubRepoList: localRepos.reversed.toList()));
          } else {
            add(const FetchTrendingRepository("javascript"));
          }



        } else {
          emit(GithubRepositoryInProgress());

          final result =
              await gitHubRepository.fetchGithubTrendingRepo(event.language);

          if (result is GraphqlResultSuccess) {
            final List<dynamic> rowData = result.data!['search']['repos'];
            final List<GithubRepo> loadedRepos = rowData
                .map((repo) =>
                    githubRepoFromJson(repo['repo'], language: event.language))
                .toList();

            emit(GithubRepositorySuccess(githubRepoList: loadedRepos.reversed.toList()));

            for (var repo in loadedRepos) {
              localDataStorage.savaRepo(repo);
            }
          }

          if (result is GraphqlResultFailure) {
            emit(GithubRepositoryFailure(
                errorMessage: result.error ?? "An error occurred"));
          }
        }
      } catch (error) {
        emit(GithubRepositoryFailure(errorMessage: error.toString()));
      }
    });
  }
}
