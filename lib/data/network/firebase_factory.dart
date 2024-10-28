import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled11/firebase_options.dart';
class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseService _instance = FirebaseService._internal(
  );
  factory FirebaseService() {
    return _instance;
  }
  FirebaseService._internal();
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }
  CollectionReference commentCollection(String postId){
    return firestore.collection('post').doc(postId).collection('comment');
  }
  CollectionReference? storyCollection(){
    try {
      return firestore.collection('story');
    } catch (e) {
      print("Error getting story data: $e");
    }
  }
  CollectionReference? postCollection(){
    try {
      return  firestore.collection('post');
    } catch (e) {
      print("Error getting post data: $e");
    }
  }

  CollectionReference? usersCollection(){
    try {
      return firestore.collection('users');
    } catch (e) {
      print("Error getting user data: $e");
    }
  }
}
