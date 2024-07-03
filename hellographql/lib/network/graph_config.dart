import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static final HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql'
  );
// Bearer
  static final AuthLink authLink = AuthLink(

  );

  static final WebSocketLink websocketLink = WebSocketLink(
    'wss://your-graphql-endpoint.com/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      initialPayload: () async {
        return {
          'Authorization': 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
        };
      },
    ),
  );

  static final Link link = authLink.concat(httpLink).concat(websocketLink);

  static final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );

  static GraphQLClient getClient() {
    return client;
  }
}