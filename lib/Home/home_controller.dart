import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Pages/login_page.dart';
import 'package:bizado/Shared/error_screen.dart';
import 'package:bizado/Shared/loading_screen.dart';
import 'package:flutter/material.dart';
import '../Services/Auth/auth_service.dart';

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorScreen(
              error: snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          return const Center(child: FeedPage());
        } else {
          return const Center(child: LoginPage());
        }
      },
    );
  }
}
