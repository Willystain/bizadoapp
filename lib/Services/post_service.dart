import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Post>> postFilter(String city, String jobType) async {
    if (city.length < 1 && jobType == 'Todos') {
      print('sem filtro');
      var ref = db
          .collection('posts')
          .where('postValid', isEqualTo: true)
          .orderBy('postDate', descending: true);

      var snapshot = await ref.get();
      var snap = snapshot;
      var posts = snap.docs.map((e) => Post.fromSnap(e));
      return posts.toList();
    }
    if (city.length < 1 && jobType != 'Todos') {
      var ref = db
          .collection('posts')
          .where('postValid', isEqualTo: true)
          .where('jobType', isEqualTo: jobType)
          .orderBy('postDate', descending: true);

      var snapshot = await ref.get();
      var snap = snapshot;
      var posts = snap.docs.map((e) => Post.fromSnap(e));
      return posts.toList();
    }
    if (city.length > 1 && jobType == 'Todos') {
      var ref = db
          .collection('posts')
          .where('postValid', isEqualTo: true)
          .where('city', isEqualTo: city)
          .orderBy('postDate');

      var snapshot = await ref.get();
      var snap = snapshot;
      var posts = snap.docs.map((e) => Post.fromSnap(e));
      return posts.toList();
    }
    if (city.length > 1 && jobType != 'Todos') {
      var ref = db
          .collection('posts')
          .where('postValid', isEqualTo: true)
          .where('city', isEqualTo: city)
          .where('jobType', isEqualTo: jobType)
          .orderBy('postDate', descending: true);

      var snapshot = await ref.get();
      var snap = snapshot;
      var posts = snap.docs.map((e) => Post.fromSnap(e));
      return posts.toList();
    } else {
      print('elseeeee');
      var ref = db
          .collection('posts')
          .where('postValid', isEqualTo: true)
          .where('city', isEqualTo: city)
          .where('jobType', isEqualTo: jobType)
          .orderBy('postDate', descending: true);

      var snapshot = await ref.get();
      var snap = snapshot;
      var posts = snap.docs.map((e) => Post.fromSnap(e));
      return posts.toList();
    }
  }

  Future<void> createPost({map = Map<String, dynamic>, postId = String}) async {
    final path = 'posts/$postId';
    final docRef = db.doc(path);
    await docRef.set(map);
  }
}
