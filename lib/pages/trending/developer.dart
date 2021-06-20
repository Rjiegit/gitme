import "package:flutter/material.dart";
import 'package:gitme/components/github_trending_tiles.dart';
import 'package:gitme/pages/trending/trending.dart';
import 'package:gitme/services/github_trending_api.dart';
import 'package:gitme/services/models/developer.dart';

class TrendingDevelopers extends StatefulWidget {
  const TrendingDevelopers({
    Key? key,
    required this.dateRange,
  }) : super(key: key);

  final TrendingDateRange dateRange;

  @override
  _TrendingDevelopersState createState() => _TrendingDevelopersState();
}

class _TrendingDevelopersState extends State<TrendingDevelopers> {
  Future<List<Developer>>? developerList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    developerList = githubTrendingClient.listDevelopers(
      since: "${widget.dateRange.toString().split('.')[1]}",
    );

    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: developerList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Developer>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DeveloperTile(
                        avatarUrl: snapshot.data![index].avatar,
                        name: snapshot.data![index].name,
                        nickName: snapshot.data![index].username,
                        repo: snapshot.data![index].repo,
                        onPressed: () {},
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 0.0),
                  );
                } else {
                  return Center(child: Text("No Data"));
                }
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
        onRefresh: () async {
          setState(() {
            developerList = githubTrendingClient.listDevelopers(
              since: "${widget.dateRange.toString().split('.')[1]}",
            );
          });
        },
      ),
    );
  }
}
