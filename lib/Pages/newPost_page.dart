import 'package:bizado/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/city_service.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  bool iconToggle = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [],
      ),
    );
  }
}
