import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Pages/newPost_page.dart';
import 'package:bizado/Pages/profile_page.dart';
import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/city_service.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../Services/global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

FocusNode _focus = FocusNode();
int _selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalVariables>(context);

    final List<Widget> _pages = <Widget>[
      FeedPage(),
      NewPostPage(),
      ProfilePage()
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
          title: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Hero(
                tag: "search",
                child: GestureDetector(
                  onTap: () {},
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AuthService().user!.displayName.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )),
          )),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: SearchBar()),
              Visibility(
                  visible: controller.cityGlobal.length > 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.cityGlobal = "";
                      });
                    },
                    child: Text("Limpar"),
                  )),
            ],
          ),
          _pages[_selectedIndex]
        ],
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
