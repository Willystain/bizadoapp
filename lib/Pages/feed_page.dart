import 'package:bizado/Services/Auth/auth_service.dart';
import 'package:bizado/Services/post_service.dart';
import 'package:bizado/Widgets/card_widget.dart';
import 'package:bizado/Widgets/search_widget.dart';
import 'package:bizado/main.dart';
import 'package:flutter/material.dart';
import '../Services/setup_riverPod.dart';
import '../models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: ref.watch(postProvider.future),
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
          print(snapshot.error);
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var posts = snapshot.data!;
          if (posts.length < 1) {
            return Center(
              child: Text('Sem resultado'),
            );
          }

          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, int index) {
                        Post currentPost = posts[index];
                        return buildCard(
                            postDate: currentPost.postDate.toDate(),
                            city: currentPost.city,
                            jobType: currentPost.jobType,
                            postText: currentPost.postText);
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
