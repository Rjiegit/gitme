import "package:flutter/material.dart";
import 'package:gitme/components/github_trending_tiles.dart';
import 'package:gitme/pages/trending/trending.dart';
import 'package:gitme/services/github_trending_api.dart';
import 'package:gitme/services/models/project.dart';

class TrendingProjects extends StatefulWidget {
  const TrendingProjects({
    Key? key,
    required this.dateRange,
  }) : super(key: key);

  final TrendingDateRange dateRange;

  @override
  _TrendingProjectsState createState() => _TrendingProjectsState();
}

class _TrendingProjectsState extends State<TrendingProjects> {
  Future<List<Project>>? projectList;

  @override
  Widget build(BuildContext context) {
    projectList = githubTrendingClient.listProjects(
      since: "${widget.dateRange.toString().split('.')[1]}",
    );

    return Scrollbar(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: projectList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  return ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProjectTile(
                        name: snapshot.data![index].fullName,
                        description: snapshot.data![index].description,
                        stars: snapshot.data![index].stars,
                        currentStars: snapshot.data![index].currentPeriodStars,
                        language: snapshot.data![index].language,
                        languageColor: snapshot.data![index].languageColor,
                        builtBy: snapshot.data![index].builtBy,
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
            projectList = githubTrendingClient.listProjects(
              since: "${widget.dateRange.toString().split('.')[1]}",
            );
          });
        },
      ),
    );
  }
}
