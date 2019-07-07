import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../taskout_model.dart';
import './pages_manager.dart';
//custom widgets
import '../widgets/general/custom_alert_dialog.dart';
import '../widgets/text/heading.dart';
import '../widgets/text/caption_text.dart';
import '../widgets/auth/background_container.dart';
import '../widgets/auth/google_signin.dart';
import '../widgets/auth/email_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/confirm_auth_button.dart';
import './signup.dart';

class LogIn extends StatelessWidget {
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
                  Heading("taskout",Color(0xff4A69FF)),
                  EmailTextField(model),
                  PasswordTextField(model),
                  ConfirmAuthButton("Log In", () {
                    String email = model.getEmail;
                    String password = model.getPassword;
                    if (!RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(email)) {
                      CustomAlertDialog().buildCustomAlertDialog(context, "Login", "Invalid Email");
                    } else if (password.length < 6) {
                      CustomAlertDialog().buildCustomAlertDialog(context, "Login", "Password should be 6 characters or more");
                    } else {
                      model.logInUser().then((String message) {
                        if (message == null || message.length < 1) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PagesManager()));
                        } else {
                          CustomAlertDialog().buildCustomAlertDialog(context, "Login", message);
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
