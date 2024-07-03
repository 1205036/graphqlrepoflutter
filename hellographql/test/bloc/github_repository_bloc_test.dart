import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_graphql/bloc/github_repository_bloc.dart';
import 'package:hello_graphql/local_store/local_storage.dart';
import 'package:hello_graphql/repositories/repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([LocalDataStorage, GitHubRepository])
void main() {
  late GithubRepositoryBloc githubRepositoryBloc;
  // late MockLocalDataStorage mockLocalDataStorage;
  // late MockGitHubRepository mockGitHubRepository;

  setUp(() {
    githubRepositoryBloc = GithubRepositoryBloc();
  });

  tearDown(() {
    githubRepositoryBloc.close();
  });

  test('Initial State is [GithubRepositoryInitial]', () {
    expect(githubRepositoryBloc.state, isA<GithubRepositoryInitial>());
  });

  group("Test Github repository Bloc", () {
    blocTest(
        "When [event.language == All Language] Should emit [ GithubRepositoryInProgress ] and [GithubRepositorySuccess] or Fire new Event  [FetchTrendingRepository(javascript)] ",
        build: () {
          return githubRepositoryBloc;
        },
        act: (bloc) => bloc.add(const FetchTrendingRepository("All Language")),
        expect: () {
          return [GithubRepositoryInProgress()];
        });
  });
}
