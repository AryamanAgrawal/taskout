import 'package:flutter/material.dart';

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