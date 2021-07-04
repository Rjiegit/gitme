import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github/github.dart';
import 'package:gitme/components/github_login_form.dart';
import 'package:gitme/services/github_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    User user = await githubClient.users.getCurrentUser();

                    _showToast("Welcome ${user.login}");

                    Navigator.pushReplacementNamed(context, "/home");
                  } catch (e) {
                    _showToast("Uh oh, your username or password is wrong...");

                    print(e);
                  }
                  progress.dismiss();
                });
              } else {
                _showToast("Please enter required fields.");
              }
            },
          )),
        ),
      ),
    );
  }

  _showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
