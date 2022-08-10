import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;
  final String uid;

  const User({
    required this.name,
    required this.email,
    required this.uid,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["userName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': name,
        'email': email,
        'id': uid,
      };
}
