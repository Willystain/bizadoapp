import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Services/Auth/auth_service.dart';
import '../Shared/login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            const SizedBox(
              height: 100,
            ),
            LoginButton(
                text: "Logar Anonimamente",
                icon: FontAwesomeIcons.userNinja,
                color: Colors.black,
                loginMethod: AuthService().anonLogin),
            const SizedBox(
              height: 20,
            ),
            LoginButton(
                text: "Logar com Google",
                icon: FontAwesomeIcons.google,
                color: Colors.grey,
                loginMethod: AuthService().googleLogin),
          ],
        ),
      ),
    );
  }
}
