import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("feed")),
      body: Center(
        child: Column(
          children: [
            Text('Welcome o the feed'),
            ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                },
                child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
