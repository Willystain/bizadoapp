import 'package:bizado/Home/home_controller.dart';
import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'Pages/login_page.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  FacebookAuth.i.webInitialize(
      appId: "596637275348954", cookie: true, xfbml: true, version: "v13.0");
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'homeController',
      routes: {
        'login': (context) => LoginPage(),
        'homeController': (context) => HomeController(),
        'searchPage': (context) => SearchBar(),
      },
      home: HomeController(),
    );
  }
}
