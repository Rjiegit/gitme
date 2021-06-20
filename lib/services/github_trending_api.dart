import 'dart:convert';

import 'package:gitme/services/models/developer.dart';
import 'package:gitme/services/models/project.dart';
import 'package:http/http.dart' as http;

class GitHubTrendingApiError extends Error {
  final String message;

  GitHubTrendingApiError(this.message);

  @override
  String toString() {
    return "GitHubTrendingApiError(message: $message)";
  }
}

class GitHubTrendingApiClient {
  late http.Client _client;
  String baseDomain = "github-trending-api.now.sh";

  GitHubTrendingApiClient({client}) {
    this._client = client != null ? client : http.Client();
  }

  Uri get baseUrl => Uri.https(baseDomain, "");

  /// Fetching response from GET https://github-trending-api.now.sh/repositories
  /// and return List of [Project]
  Future<List<Project>> listProjects({String? language, String? since}) async {
    var requestUrl = Uri.https(baseDomain, "/repositories", {
      if (language != null) "language": language,
      if (since != null) "since": since,
    });
    final resp = await _client.get(requestUrl);

    if (resp.statusCode != 200) {
      throw GitHubTrendingApiError(resp.body);
    }

    return jsonDecode(resp.body)
        .map<Project>((project) => Project.fromJson(project))
        .toList();
  }

  /// Fetching response from GET https://github-trending-api.now.sh/developers
  /// and return List of [Developer]
  Future<List<Developer>> listDevelopers(
      {String? language, String? since}) async {
    var requestUrl = Uri.https(baseDomain, "/developers", {
      if (language != null) "language": language,
      if (since != null) "since": since,
    });
    final resp = await _client.get(requestUrl);

    if (resp.statusCode != 200) {
      throw GitHubTrendingApiError(resp.body);
    }

    return jsonDecode(resp.body)
        .map<Developer>((developer) => Developer.fromJson(developer))
        .toList();
  }
}
