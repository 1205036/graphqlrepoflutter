
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../network/gragh_service.dart';
import '../network/graph_result.dart';

class GitHubRepository {
  late GraphqlService graphqlService = GraphqlService();


  Future<GraphqlResult<dynamic>> fetchGithubTrendingRepo(
      String language) async {
    final String getCountryQueryByCode = """ 
    query  { 
            search(
                    type:REPOSITORY,
                    query:"language: $language",
                    last: 15
                 ) {
                       repos: edges{
                       repo:node{
                      ... on Repository {
                        url,
                        name,
                        description,
                        createdAt,
                        updatedAt,
                        stargazerCount
                    }
                  }
                },
                pageInfo {
                  endCursor
                  hasNextPage
                }
            }
       }
  """;

    // stargazerCount
    final queryOptions = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: gql(getCountryQueryByCode),
      variables: {
        "language": language,
      },
    );

    return await graphqlService.query(queryOptions: queryOptions);
  }
}

