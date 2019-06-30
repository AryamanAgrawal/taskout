import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../taskout_model.dart';
import '../pages/something.dart';
//custom widgets
import '../widgets/text/app_heading.dart';
import '../widgets/text/caption_text.dart';
import '../widgets/auth/background_container.dart';
import '../widgets/auth/google_signin.dart';
import '../widgets/auth/username_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/confirm_auth_button.dart';
import './signup.dart';

class LogIn extends StatelessWidget {
  void _buildErrorDisplayingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log In"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("DISMISS"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundContainer(),
        Align(
          alignment: FractionalOffset.center,
          child: ScopedModelDescendant<TaskoutModel>(
            builder: (BuildContext context, Widget child, TaskoutModel model) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  AppHeading(),
                  UsernameTextField(model),
                  PasswordTextField(model),
                  ConfirmAuthButton("Log In", () {
                    model.signUp = false;
                    String username = model.getUsername;
                    String password = model.getPassword;
                    if (username.length < 4 ||
                        username.split(" ").length != 1) {
                      _buildErrorDisplayingDialog(context,
                          "Username should be one word and 5 characters or more");
                    } else if (password.length < 6) {
                      _buildErrorDisplayingDialog(
                          context, "Password should be 6 characters or more");
                    } else {
                      model.logInUser().then((String message) {
                          if (message == null || message.length < 1) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Something()));
                          } else {
                            _buildErrorDisplayingDialog(context, message);
                          }
                        });
                    }
                  })
                ],
              );
            },
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: BottomButtons(),
        )
      ],
    );
  }
}

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CaptionText("- OR -", Colors.black38),
          SizedBox(
            height: 5.0,
          ),
          GoogleSignInButton(),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SignUp()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CaptionText("Do not have an account?", Colors.black45),
                SizedBox(
                  width: 5.0,
                ),
                CaptionText("Sign Up", Color(0xff4A69FF))
              ],
            ),
          )
        ],
      ),
    );
  }
}
