part of 'github_repository_bloc.dart';

sealed class GithubRepositoryState extends Equatable {
  const GithubRepositoryState();
}

final class GithubRepositoryInitial extends GithubRepositoryState {
  @override
  List<Object> get props => [];
}


class GithubRepositoryInProgress extends GithubRepositoryState{
  @override
  List<Object?> get props => [];
}

class GithubRepositorySuccess extends GithubRepositoryState{
  final List<GithubRepo> githubRepoList;

  const GithubRepositorySuccess({required this.githubRepoList});

  @override
  List<Object?> get props => [githubRepoList];
}

class GithubRepositoryFailure extends GithubRepositoryState{
  final String errorMessage;

  const GithubRepositoryFailure({required this.errorMessage});
  @override
  List<Object?> get props => [];
}
