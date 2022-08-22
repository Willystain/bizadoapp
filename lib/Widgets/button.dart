import 'package:bizado/Pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/hero_route.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(
            builder: (context) {
              return const SearchPage();
            },
          ));
        },
        child: Hero(
          tag: "aaaa",
          child: Material(
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
