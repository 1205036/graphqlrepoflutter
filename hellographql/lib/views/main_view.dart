import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/github_repository_bloc.dart';
import 'details_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedLanguage = "all";
  final List<String> language = [
    "all",
    "Javascript",
    "Rust",
    "Go",
    "Java",
    "C++",
    "Dart",
    "Ruby",
    "Scala"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        selectedLanguage = value!;
                      });

                      BlocProvider.of<GithubRepositoryBloc>(context)
                          .add(FetchTrendingRepository(selectedLanguage));
                      // Call Bloc event to fetch new repos based on language
                    },
                    items:
                        language.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<GithubRepositoryBloc>(context)
                        .add(ClearCache());
                  },
                  child: const Text("Clear cache"),
                ),
              ],
            ),
            BlocConsumer<GithubRepositoryBloc, GithubRepositoryState>(
              listener: (context, state) {
                if (state is GithubRepositoryFailure) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const SizedBox(
                          height: 60,
                          width: 100,
                          child: AlertDialog(
                            title: Text("Error occurred"),
                            content: Text(
                                "Something went wrong, Please try again later."),
                          ),
                        );
                      });
                }
              },
              builder: (context, state) {
                if (state is GithubRepositoryInProgress) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is GithubRepositorySuccess) {
                  if (state.githubRepoList.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "Have no repositories, please fetch More",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: state.githubRepoList.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsView(
                                    githubRepo: state.githubRepoList[i])));
                          },
                          child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(10),
                              height: 130,
                              decoration: const BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    // leading: Text(
                                    //   state.githubRepoList[i].stars ?? "test",
                                    //   style:
                                    //       Theme.of(context).textTheme.bodySmall,
                                    // ),
                                    title: Text(
                                      state.githubRepoList[i].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    subtitle: Text(
                                        state.githubRepoList[i].description,
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    trailing: Text(
                                      state.githubRepoList[i].language ?? "",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 17.0),
                                    child: Text(
                                      state.githubRepoList[i].url,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Colors.blue,
                                              overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    ));
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
