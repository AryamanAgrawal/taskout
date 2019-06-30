import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../taskout_model.dart';

//custom widgets
import '../widgets/text/app_heading.dart';
import '../widgets/text/caption_text.dart';
import '../widgets/auth/background_container.dart';
import '../widgets/auth/google_signin.dart';
import '../widgets/auth/username_field.dart';
import '../widgets/auth/email_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/confirm_auth_button.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                AppHeading(),
                UsernameTextField(),
                EmailTextField(),
                PasswordTextField(),
                ScopedModelDescendant<TaskoutModel>(
                  builder:
                      (BuildContext context, Widget child, TaskoutModel model) {
                    return ConfirmAuthButton("Sign Up", () {
                      model.signUp = true;
                      _formKey.currentState.validate();
                    });
                  },
                )
              ],
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
