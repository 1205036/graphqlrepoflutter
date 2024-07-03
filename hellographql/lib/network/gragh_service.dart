
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graph_config.dart';
import 'graph_result.dart';

abstract class NetworkServices<T> {
  Future<GraphqlResult<T>> query({required QueryOptions queryOptions});

  Future<GraphqlResult<T>> mutation({required MutationOptions mutationOptions});
}





class GraphqlService implements NetworkServices {
  final client = GraphQlConfig.getClient();

  @override
  Future<GraphqlResult> query({required QueryOptions<Object?> queryOptions}) async {
    final QueryResult result = await client.query(queryOptions);

    if (result.hasException) {
      return GraphqlResultFailure(error: result.exception.toString());
    } else {
      return GraphqlResultSuccess<dynamic>(data: result.data);
    }
  }

  @override
  Future<GraphqlResult> mutation(
      {required MutationOptions<Object?> mutationOptions}) async {
    final QueryResult result = await client.mutate(mutationOptions);

    if (result.hasException) {
      return GraphqlResultFailure(error: result.exception.toString());
    } else {
      print('object');
      return GraphqlResultSuccess(data: result.data);
    }
  }
}
