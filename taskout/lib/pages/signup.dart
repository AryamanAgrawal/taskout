import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../taskout_model.dart';
import '../pages/home.dart';

//custom widgets
import '../widgets/text/heading.dart';
import '../widgets/text/caption_text.dart';
import '../widgets/auth/background_container.dart';
import '../widgets/auth/username_field.dart';
import '../widgets/auth/email_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/confirm_auth_button.dart';

class SignUp extends StatelessWidget {
  void _buildErrorDisplayingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Up"),
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfffafafa),
      body: Stack(
        children: <Widget>[
          BackgroundContainer(),
          Align(
            alignment: FractionalOffset.center,
            child: ScopedModelDescendant<TaskoutModel>(
              builder:
                  (BuildContext context, Widget child, TaskoutModel model) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Heading("taskout",Color(0xff4A69FF)),
                    UsernameTextField(model),
                    EmailTextField(model),
                    PasswordTextField(model),
                    ConfirmAuthButton("Sign Up", () {
                      String username = model.getUsername;
                      String email = model.getEmail;
                      String password = model.getPassword;
                      if (username.length < 4 ||
                          username.split(" ").length != 1) {
                        model.turnOffLoading();
                        _buildErrorDisplayingDialog(context,
                            "Username should be one word and 5 characters or more");
                      } else if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(email)) {
                        model.turnOffLoading();
                        _buildErrorDisplayingDialog(context, "Invalid Email");
                      } else if (password.length < 6) {
                        model.turnOffLoading();
                        _buildErrorDisplayingDialog(
                            context, "Password should be 6 characters or more");
                      } else {
                        model.signUpUser().then((String message) {
                          if (message == null || message.length < 1) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Home()));
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
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  void _buildErrorDisplayingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Up"),
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

  Widget _buildGoogleSignUpButton() {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        child: ScopedModelDescendant<TaskoutModel>(
          builder: (BuildContext context, Widget child, TaskoutModel model) {
            return FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/icons/google.png"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "PROCEED WITH GOOGLE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Choose a username"),
                      content: UsernameTextField(
                        model,
                        shouldHavePadding: true,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("PROCEED"),
                          onPressed: () {
                            model.signUpWithGoogle = true;
                            model.signInWithGoogle().then((String message) {
                              print("padamchopra: " + message);
                              if (message == null || message.length == 0) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home()));
                              } else {
                                _buildErrorDisplayingDialog(context, message);
                              }
                            });
                          },
                        )
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.black12,
            width: 0.5,
          ),
        ),
      ),
    );
  }

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
          _buildGoogleSignUpButton(),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CaptionText("Already have an account?", Colors.black45),
                SizedBox(
                  width: 5.0,
                ),
                CaptionText("Sign In", Color(0xff4A69FF))
              ],
            ),
          )
        ],
      ),
    );
  }
}
