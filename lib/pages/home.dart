import 'package:flutter/material.dart';
import 'package:gitme/components/circle_avatar_button.dart';
import 'package:gitme/components/drawer_tile.dart';
import 'package:gitme/pages/activity.dart';
import 'package:gitme/pages/issue.dart';
import 'package:gitme/pages/repo.dart';
import 'package:gitme/pages/search.dart';
import 'package:gitme/utils.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hnpwa_client/hnpwa_client.dart';

// 主頁面
class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 0.0,
          leading: CircleAvatarButton(
            avatarImage: NetworkImage(
              "https://placekitten.com/200/300",
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Repo"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: GitmeSearchDelegate(),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            RepoPage(),
            ActivityPage(),
            IssuePage(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                accountName: Text("Jie"),
                accountEmail: Text("test@mail.com"),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://placekitten.com/200/300",
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/profile");
                  },
                ),
                otherAccountsPictures: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              DrawerTile(
                icon: Icon(Icons.trending_up),
                text: "Trending",
                onPressed: () {
                  Navigator.of(context).pushNamed("/trending");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.settings),
                text: "Setting",
                onPressed: () {
                  Navigator.of(context).pushNamed("/setting");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.info),
                text: "About",
                onPressed: () {
                  Navigator.of(context).pushNamed("/about");
                },
              ),
              DrawerTile(
                icon: Icon(Icons.power_settings_new),
                text: "Sign out",
                onPressed: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content: Text("Are you sure to exit current account."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", ModalRoute.withName('/')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 首頁
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HnpwaClient hnClient = HnpwaClient();
  List<FeedItem>? _hnTops;
  List<FeedItem>? _hnNews;

  final List ghTrends = [
    {
      "author": "lumen",
      "name": "lumen",
      "avatar": "https://github.com/lumen.png",
      "url": "https://github.com/lumen/lumen",
      "description":
          "An alternative BEAM implementation, designed for WebAssembly",
      "language": "Rust",
      "languageColor": "#dea584",
      "stars": 850,
      "forks": 21,
    },
    {
      "author": "outline",
      "name": "outline",
      "avatar": "https://github.com/outline.png",
      "url": "https://github.com/outline/outline",
      "description":
          "The fastest wiki and knowledge base for growing teams. Beautiful, feature rich, markdown compatible and open source.",
      "language": "JavaScript",
      "languageColor": "#f1e05a",
      "stars": 5342,
      "forks": 329,
    },
    {
      "author": "tophubs",
      "name": "TopList",
      "avatar": "https://github.com/tophubs.png",
      "url": "https://github.com/tophubs/TopList",
      "description":
          "今日热榜，一个获取各大热门网站热门头条的聚合网站，使用Go语言编写，多协程异步快速抓取信息，预览:https://www.printf520.com/hot.html",
      "language": "Go",
      "languageColor": "#00ADD8",
      "stars": 1960,
      "forks": 332,
    }
  ];

  @override
  void initState() {
    super.initState();
    fetchHNData();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            ListTile(
              dense: true,
              title: Text("Hackernews Top"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            Divider(
              height: 0.0,
            ),
            ...buildHNTopStories(context),
            Container(
              child: Divider(
                height: 8.0,
                color: Colors.grey[200],
              ),
              color: Colors.grey[200],
            ),
            ListTile(
              dense: true,
              title: Text("Hackernews New"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            Divider(
              height: 0.0,
            ),
            ...buildHNNewStories(context),
            Container(
              child: Divider(
                height: 8.0,
                color: Colors.grey[200],
              ),
              color: Colors.grey[200],
            ),
            ListTile(
              dense: true,
              title: Text("Github Trending"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            Divider(
              height: 0.0,
            ),
            ...buildGHTrends(context),
          ],
        ),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1)).then((value) {
            fetchHNData();
          });
        },
      ),
    );
  }

  Future fetchHNData() async {
    Feed hnNew = await hnClient.news();
    Feed hnNewest = await hnClient.newest();
    setState(() {
      _hnTops = hnNew.items;
      _hnNews = hnNewest.items;
    });
  }

  buildHNTopStories(BuildContext context) {
    if (_hnTops == null) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    }
    return ListTile.divideTiles(
            context: context,
            tiles: _hnTops!.sublist(0, 4).map((item) {
              return ListTile(
                title: Text(item.title),
                subtitle:
                    Text("by ${item.user} | ${item.commentsCount} comments"),
                onTap: () => launchURL(item.url),
              );
            }).toList())
        .toList();
  }

  buildHNNewStories(BuildContext context) {
    if (_hnNews == null) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        )
      ];
    }
    return ListTile.divideTiles(
            context: context,
            tiles: _hnNews!.sublist(0, 4).map((item) {
              return ListTile(
                title: Text(item.title),
                subtitle:
                    Text("by ${item.user} | ${item.commentsCount} comments"),
                onTap: () => launchURL(item.url),
              );
            }).toList())
        .toList();
  }

  buildGHTrends(BuildContext context) {
    return ListTile.divideTiles(
            context: context,
            tiles: ghTrends.map((repo) {
              return ListTile(
                title: Text("${repo["author"]} / ${repo["name"]}"),
                subtitle: Text(
                    "${repo["language"]}   ${repo["stars"]}   ${repo["forks"]}"),
                onTap: () {},
              );
            }).toList())
        .toList();
  }
}
