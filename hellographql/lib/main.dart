import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_graphql/views/main_view.dart';
import 'package:hive_flutter/adapters.dart';

import 'bloc/github_repository_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GithubRepositoryBloc()
        ..add(const FetchTrendingRepository("All Language")),
      child: MaterialApp(
        title: 'Flutter GraphQl',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter GraphQl'),
      ),
    );
  }
}

