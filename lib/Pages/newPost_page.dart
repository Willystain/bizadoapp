import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Widgets/autocomplete_widget.dart';
import 'package:bizado/Widgets/dropDown_jobType.dart';
import 'package:flutter/material.dart';
import 'package:bizado/Services/post_service.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/post_service.dart';
import '../Services/setup_riverPod.dart';

class NewPostPage extends ConsumerStatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends ConsumerState<NewPostPage> {
  TextEditingController postTextValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('build newPostPage');
    String jobTypeNew = ref.watch(jobTypeNewPost);
    String cityValue = ref.watch(cityNewPost);
    String user = ref.watch(currentUser);
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
            DropDownRiver(),
            ElevatedButton(
                onPressed: () {
                  var idGenerator = Uuid().v4();
                  setState(() {
                    PostService().createPost(map: {
                      'postText': postTextValue.text,
                      'city': cityValue,
                      'jobType': jobTypeNew,
                      'postValid': true,
                      'userName': user,
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
