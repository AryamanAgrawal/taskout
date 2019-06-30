import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Widget _buildWelcomeText() {
    return Text(
      "taskout",
      style: TextStyle(
        fontSize: 36.0,
        color: Color(0xff4A69FF),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildColoredContainer(Widget widget) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 8.0,
      ),
      //color: Color(0xff4A69FF),
      child: widget,
    );
  }

  Widget _buildUsernameTextField() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Color(0xffC7D0F8),
      child: TextField(
        cursorColor: Colors.blue.shade900,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black26),
          suffixIcon: Icon(
            Icons.person_outline,
            color: Color(0xff4A69FF),
            //color: Color(0xffcccccc),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
          labelText: "Username",
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Color(0xffC7D0F8),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.blue.shade900,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black26),
          suffixIcon: Icon(
            Icons.alternate_email,
            color: Color(0xff4A69FF),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
          labelText: "Email",
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Color(0xffC7D0F8),
      child: TextField(
        obscureText: true,
        cursorColor: Colors.blue.shade900,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black26),
          suffixIcon: Icon(
            Icons.lock_outline,
            color: Color(0xff4AD284),
            //color: Color(0xffcccccc),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
          labelText: "Password",
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCenterAlignedSignUpButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: Container(
        child: FlatButton(
          /*child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 24.0,
          ),*/
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                width: 3.0,
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 14.0,
              ),
              SizedBox(
                width: 4.0,
              ),
            ],
          ),
          onPressed: () {},
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xff4A69FF), Color(0xff4AD284)],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "productsans",
      ),
      home: Scaffold(
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
                  _buildWelcomeText(),
                  _buildColoredContainer(_buildUsernameTextField()),
                  _buildColoredContainer(_buildEmailTextField()),
                  _buildColoredContainer(_buildPasswordTextField()),
                  _buildColoredContainer(_buildCenterAlignedSignUpButton())
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: BottomButtons(),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: Image(
        image: AssetImage("assets/home/floatingobjects.png"),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  //Google Sign In
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn();

  Future<dynamic> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    if (googleSignInAccount == null) {
      return false;
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final FirebaseUser user = await _fAuth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      return user;
    }
  }

  Widget _buildSignUpWithGoogleButton() {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        child: FlatButton(
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
          onPressed: _signIn,
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
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "- OR -",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 12.0, color: Colors.black38),
          ),
          SizedBox(
            height: 5.0,
          ),
          _buildSignUpWithGoogleButton(),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12.0, color: Colors.black45),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Log In",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12.0, color: Color(0xff4A69FF)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
