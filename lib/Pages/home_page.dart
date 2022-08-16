import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Pages/newPost_page.dart';
import 'package:bizado/Pages/profile_page.dart';
import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;

const List<Widget> _pages = <Widget>[FeedPage(), NewPostPage(), ProfilePage()];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text('NewAppBar'),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(
                        Icons.logout_outlined,
                        size: 30,
                      ),
                      onPressed: () {
                        AuthService().signOut();
                      }),
                ],
              ),
            ]),
        body: _pages[_selectedIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
        initialActiveIndex: 0,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
