import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/github.dart';

GitHub githubClient = GitHub(
  auth: Authentication.withToken(dotenv.env["GITHUB_PERSONAL_ACCESS_TOKEN"]),
);

GitHub getGithubApiClient({username, password}) {
  return GitHub(auth: Authentication.basic(username, password));
}

GitHub getGithubApiClientByToken() {
  return GitHub(
    auth: Authentication.withToken(dotenv.env["GITHUB_PERSONAL_ACCESS_TOKEN"]),
  );
}
