import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Pages/newPost_page.dart';
import 'package:bizado/Pages/profile_page.dart';
import 'package:bizado/Pages/search_page.dart';
import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/city_service.dart';
import 'package:bizado/Services/hero_route.dart';
import 'package:bizado/Widgets/button.dart';
import 'package:bizado/Widgets/search_widget.dart';
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Hero(
                tag: "search",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return const SearchPage();
                    }));
                  },
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pesquisar",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                )),
          )),
      body: Column(
        children: [_pages[_selectedIndex]],
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
