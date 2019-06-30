import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn();

  Future<dynamic> _signIn(BuildContext context) async {
    SnackBar snackBar = SnackBar(
      content: Text("Yay a snackbar"),
    );
    Scaffold.of(context).showSnackBar(snackBar);
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

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            _signIn(context);
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
}
