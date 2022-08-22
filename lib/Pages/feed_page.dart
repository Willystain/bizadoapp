import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var checks;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: AuthService().postStream(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var posts = snapshot.data!;
          return Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
                  child: SearchBar(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, int index) {
                        Post currentPost = posts[index];
                        return ListTile(
                          leading: Text(currentPost.postText.toString()),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
