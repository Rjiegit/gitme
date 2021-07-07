import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:github/github.dart';
import 'package:gitme/components/github_login_form.dart';
import 'package:gitme/services/github_api.dart';
import 'package:gitme/stores/account.dart';
import 'package:gitme/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var account = Provider.of<AccountModel>(context);

    return ProgressHUD(
      backgroundColor: Colors.black87,
      textStyle: Theme.of(context).accentTextTheme.subtitle1!,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: SingleChildScrollView(child: GithubLoginForm(
            onLogin: (state) {
              if (state.formKey.currentState!.validate()) {
                final progress = ProgressHUD.of(context);
                progress!.showWithText("Loading...");

                FocusScope.of(context).requestFocus(new FocusNode());

                Future.delayed(Duration(milliseconds: 100), () async {
                  try {
                    githubClient = getGithubApiClientByToken();
                    CurrentUser currentUser =
                        await githubClient.users.getCurrentUser();

                    account.updateUser(currentUser);
                    showToast(
                        context: context,
                        message: "Welcome ${currentUser.login} ~~");

                    Navigator.pushReplacementNamed(context, "/home");
                  } catch (e) {
                    showToast(
                      context: context,
                      message: "Uh oh, your username or password is wrong...",
                      type: NotifyType.warning,
                    );

                    print(e);
                  }
                  progress.dismiss();
                });
              } else {
                showToast(
                  context: context,
                  message: "Please enter required fields.",
                  type: NotifyType.warning,
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
