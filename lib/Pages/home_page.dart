import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Pages/newPost_page.dart';
import 'package:bizado/Pages/profile_page.dart';
import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/city_service.dart';
import 'package:bizado/Widgets/dropDown_jobType.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:bizado/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../Services/setup_riverPod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

const List<String> list = <String>[
  'Todos',
  'Carpinteiro',
  'Limpeza',
  'Motorista',
];

String dropdownValue = list.first;

FocusNode _focus = FocusNode();
int _selectedIndex = 0;

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedIndex);
    final List<Widget> _pages = <Widget>[
      FeedPage(),
      NewPostPage(),
      ProfilePage()
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Visibility(
                visible: _selectedIndex == 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 14,
                    ),
                    Flexible(child: SearchBar(), flex: 2),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(child: DropDownRiver()),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _pages[_selectedIndex]
            ],
          ),
        ),
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
