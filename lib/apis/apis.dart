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
        lat: 0,
        long: 0,
        about: '',
        createdAt: '',
        lastActive: '',
        isOnline: true,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(myUser.toJson());
  }

  static updateLocation(double lat, double lng) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(user.uid).update({'lat': lat, 'long': lng});
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return firestore.collection('users').withConverter<MyUser>(
        fromFirestore: ((snapshot, options) {
      return MyUser.fromJson(snapshot.data()!);
    }), toFirestore: (user, options) {
      return user.toJson();
    });
  }

  static Future<MyUser?> getFutureOfUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }
}
