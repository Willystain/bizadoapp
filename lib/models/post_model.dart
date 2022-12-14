import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String city;
  String postText = '';
  String userName = '';
  String postId = '';
  Timestamp postDate;
  String jobType = '';

  bool postValid = true;
  DocumentReference docRef;

  Post(
      {required this.jobType,
      required this.city,
      required this.postId,
      required this.postDate,
      required this.postText,
      required this.userName,
      required this.docRef,
      this.postValid = true});

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        jobType: snapshot['jobType'],
        city: snapshot["city"],
        postId: snap.id,
        postDate: snapshot['postDate'],
        postText: snapshot["postText"],
        userName: snapshot["userName"],
        docRef: snap.reference);
  }

  factory Post.fromDocument(DocumentSnapshot snap) {
    return Post(
        jobType: snap['jobType'],
        city: snap['city'],
        postDate: snap['postDate'],
        postId: snap['postId'],
        postText: snap["postText"],
        userName: snap["userName"],
        docRef: snap['docRef']);
  }

  save() {
    if (docRef == null) {
    } else {
      docRef.update({postText: 'postText'});
    }
  }
}
