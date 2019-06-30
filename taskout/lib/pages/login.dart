import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              PasswordTextField(),
              ConfirmAuthButton("Log In", () {})
            ],
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
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignUp()));
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