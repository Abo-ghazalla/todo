import 'package:flutter/material.dart';
import 'package:todo_task/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: RaisedButton.icon(
          label: Text("Sing In With Google"),
          icon: Image.asset(
            "assets/images/google.png",
            width: 50,
          ),
          onPressed: googleSignIn,
        ),
      ),
    );
  }
}
