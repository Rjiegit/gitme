import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/github.dart';

GitHub githubClient = GitHub(
  auth: Authentication.withToken(dotenv.env["GITHUB_PERSONAL_ACCESS_TOKEN"]),
);
