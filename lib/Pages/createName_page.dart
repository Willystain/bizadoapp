import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/Auth/auth_service.dart';

class CreateName extends StatelessWidget {
  const CreateName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AuthService().signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Column(
          children: [Text('Create UserName')],
        ),
      ),
    );
  }
}
