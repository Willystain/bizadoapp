import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/global_variables.dart';
import 'package:bizado/Widgets/autocomplete_widget.dart';
import 'package:flutter/material.dart';
import 'package:bizado/Services/post_service.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/city_service.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalVariables>(context, listen: true);
    final auth = Provider.of<AuthService>(context);
    final post = Provider.of<PostService>(context);
    print('build newPostPage');
    String cityValue = controller.cityCreatePost;
    String PostText = '';
    String userName =
        auth.user!.emailVerified ? auth.user!.displayName.toString() : 'noUser';
    TextEditingController postTextValue = new TextEditingController();

    initState() {
      userName = auth.user!.displayName.toString();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'PostDescription',
              ),
              controller: postTextValue,
            ),
            const SizedBox(
              height: 20,
            ),
            const AutoCompleteField(),
            ElevatedButton(
                onPressed: () {
                  var idGenerator = Uuid().v4();
                  setState(() {
                    cityValue = controller.cityCreatePost;
                    print({'$cityValue cityvalue'});
                    post.createPost(map: {
                      'postText': postTextValue.text,
                      'city': cityValue,
                      'postValid': true,
                      'userName': userName,
                      'postId': idGenerator,
                      'postDate': Timestamp.fromDate(DateTime.now()),
                    }, postId: idGenerator);
                  });
                },
                child: const Text('PRESS')),
            Text(cityValue)
          ],
        ),
      ),
    );
  }
}
