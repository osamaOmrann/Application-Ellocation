import 'package:application_ellocation/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final myUser = MyUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        image: user.photoURL.toString(),
        created_at: time,
        is_online: false,
        last_active: time,
        push_token: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(myUser.toFirestore());
  }
}
