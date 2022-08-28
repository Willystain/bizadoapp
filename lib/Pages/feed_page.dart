import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/global_variables.dart';
import 'package:bizado/Services/post_service.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final controller = Provider.of<GlobalVariables>(context);
    final post = Provider.of<PostService>(context);
    print(controller.cityGlobal);
    return FutureBuilder<List<Post>>(
      future: controller.cityGlobal.isEmpty
          ? post.postStream()
          : post.postFilter(controller.cityGlobal),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Container(
              child: Center(child: const CircularProgressIndicator()),
            ),
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
                const Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
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
                            icon: const Icon(Icons.delete),
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
