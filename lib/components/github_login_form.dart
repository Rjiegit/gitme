import "package:flutter/material.dart";

class GithubLoginForm extends StatefulWidget {
  const GithubLoginForm({
    Key? key,
    this.onLogin,
  }) : super(key: key);

  final Function(_GithubLoginFormState state)? onLogin;

  @override
  _GithubLoginFormState createState() => _GithubLoginFormState();
}

class _GithubLoginFormState extends State<GithubLoginForm> {
  bool _obscureText = true;
  FocusNode _passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your GitHub username";
                  }
                  return null;
                },
                controller: usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Name *",
                  hintText: "Your Github account username",
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                focusNode: _passwordFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your GitHub password";
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: _obscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  labelText: "Password *",
                  hintText: "Your Github account password",
                ),
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  widget.onLogin!(this);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
