import "package:flutter/material.dart";
import 'package:github/github.dart';
import 'package:gitme/components/github_tiles.dart';
import 'package:gitme/services/github_api.dart';
import 'package:gitme/stores/account.dart';
import 'package:gitme/utils.dart';
import 'package:provider/provider.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, account, Widget? child) {
        if (account.repos == null) {
          account.fetchRepos();
          return Center(child: CircularProgressIndicator());
        } else {
          return Scrollbar(
            child: RefreshIndicator(
              child: buildRepoListView(account.repos!),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                await account.refreshRepos();
                showToast(context: context, message: "Refresh done");
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Repository>> fetchRepos() async {
    CurrentUser user = await githubClient.users.getCurrentUser();
    return githubClient.repositories.listUserRepositories(user.login!).toList();
  }

  ListView buildRepoListView(List<Repository> repos) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: repos.length,
      itemBuilder: (BuildContext context, int index) {
        return RepoTile(
          name: "${repos[index].owner!.login}/${repos[index].name}",
          description: repos[index].description,
          stars: repos[index].stargazersCount,
          language: repos[index].language,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 0.0),
    );
  }
}
