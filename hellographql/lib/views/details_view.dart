import 'package:flutter/material.dart';

import '../models/github_repo.dart';


class DetailsView extends StatelessWidget {
  const DetailsView({required this.githubRepo, super.key});

  final GithubRepo githubRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme.inverseSurface,
        title: const Text("Details View"),
      ),
      body: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          ListTile(
          // leading: Text(
          // githubRepo.stars ?? "",
          //   style: Theme
          //       .of(context)
          //       .textTheme
          //       .bodySmall,
          // ),
          title: Text(
          githubRepo.name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
    ),
    subtitle: Text(githubRepo.description,
    maxLines: 3, style: Theme.of(context).textTheme.bodySmall),
    trailing: Text(
    githubRepo.language ?? "",
    style: Theme.of(context).textTheme.bodySmall,
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 17.0),
    child: Text(
    githubRepo.url,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
    color: Colors.blue, overflow: TextOverflow.ellipsis),
    ),
    ),
    ],
    )
    ,
    )
    ,
    );
  }
}
