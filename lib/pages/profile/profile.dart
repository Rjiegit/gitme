import "package:flutter/material.dart";
import 'package:gitme/components/profile/profile_info.dart';
import 'package:gitme/pages/profile/follow.dart';
import 'package:gitme/pages/repo.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("Jie"),
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      ProfileInfo(
                        avatarUrl: "https://placekitten.com/200/300",
                        name: "Jie",
                        location: "New Taipei City, Taiwan",
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  labelPadding: EdgeInsets.zero,
                  tabs: <Widget>[
                    Tab(text: "Repos"),
                    Tab(text: "Stars"),
                    Tab(text: "Followers"),
                    Tab(text: "Following"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              RepoPage(),
              RepoPage(),
              FollowPage(),
              FollowPage(),
            ],
          ),
        ),
      ),
      length: 4,
    );
  }
}
