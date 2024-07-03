part of 'github_repository_bloc.dart';

sealed class GithubRepositoryEvent extends Equatable {
  const GithubRepositoryEvent();
}

class FetchTrendingRepository extends GithubRepositoryEvent {
  final String language;

  const FetchTrendingRepository(this.language);

  @override
  List<Object?> get props => [];
}

class ClearCache extends GithubRepositoryEvent {
  @override
  List<Object?> get props => [];
}
