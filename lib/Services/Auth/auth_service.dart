import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bizado/models/user_model.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../models/post_model.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // handle error
    }
  }

  // FACEBOOK SIGN IN
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);

      final userData = await FacebookAuth.i.getUserData();
      final userId = userData["id"];
      model.User newUser = await model.User(
          name: userData["name"],
          uid: userData["id"],
          email: userData["email"]);
      db.collection('users').doc(userId).set(newUser.toJson());
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e); // Displaying the error message
    }
  }

  Future<String?> googleuser() async {
    final googleUser = await GoogleSignIn().signIn();
    final nome = googleUser!.displayName;
    return nome;
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      model.User newUser = await model.User(
          name: googleUser.displayName.toString(),
          uid: googleUser.id,
          email: googleUser.email);
      db.collection('users').doc(newUser.uid).set(newUser.toJson());
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  Future<List<Post>> postStream() async {
    var ref = db.collection('posts').where('postValid', isEqualTo: true);
    var snapshot = await ref.get();
    var snap = snapshot;
    var posts = snap.docs.map((e) => Post.fromSnap(e));
    return posts.toList();
  }

  Future<List<Post>> postFilter(String city) async {
    var ref = db
        .collection('posts')
        .where('postValid', isEqualTo: true)
        .where('city', isEqualTo: city);
    var snapshot = await ref.get();
    var snap = snapshot;
    var posts = snap.docs.map((e) => Post.fromSnap(e));
    return posts.toList();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
