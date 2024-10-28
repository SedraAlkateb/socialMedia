import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/data/network/firebase_factory.dart';
import 'package:untitled11/domain/models/models.dart';
///0 firebase , 1 sql
class FirebaseApi {
  FirebaseService firebaseService;

  FirebaseApi(this.firebaseService);

  Future<UserModel> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await firebaseService.usersCollection()!.doc(userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        return UserModel.fromJson(userData,userSnapshot.id);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      print("Error getting user data: $e");
      throw Exception("$e");
    }
  }
  Future<StoriesModel> getStories()  async {
    try {
      QuerySnapshot storySnapshot = await firebaseService.storyCollection()!.get();
      List<StoryModel> storiesList =  [];
      for (var storyDoc in storySnapshot.docs) {
        Map<String, dynamic> storyData = storyDoc.data() as Map<String, dynamic>;
        DocumentSnapshot userDoc = await firebaseService.usersCollection()!
            .doc(storyData['userId'])
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          storiesList.add(
              StoryModel.fromJson(storyData, userData, storyDoc.id, userDoc.id));
        }
      }
      return StoriesModel(storiesList, 0);
    } catch (e) {
      throw(Failure(-9,e.toString()));

    }
  }
  Future<PostsModel> getPosts() async {
    try {
      QuerySnapshot postSnapshot = await firebaseService.postCollection()!.get();
      List<PostModel> postsList =  [];
      for (var postDoc in postSnapshot.docs) {
        Map<String, dynamic> postData = postDoc.data() as Map<String, dynamic>;
        DocumentSnapshot userDoc = await firebaseService.usersCollection()!
            .doc(postData['userId'])
            .get();
        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          postsList.add(
              PostModel.fromJson(postData, userData, postDoc.id, userDoc.id));
        }
      }
      return PostsModel(postsList, 0);
    } catch (e) {
      throw(Failure(-9,e.toString()));

    }
  }
  Future<List<Comment>>getComment(String id)async{
    CollectionReference commentsDoc = firebaseService.commentCollection(id);
    QuerySnapshot commentSnapshot = await commentsDoc.get();
    List<Comment> comments=[];
    for (var commentDoc in commentSnapshot.docs) {
      Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;
      DocumentSnapshot userDoc = await firebaseService.usersCollection()!
          .doc(commentData['userId'])
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        comments.add(Comment.fromJson(userData,commentData, commentDoc.id,userDoc.id));
      }

    }
    return comments;
  }
  setComment(String postId,CommentAdd comment)async{
    DocumentReference postRef = firebaseService.postCollection()!.doc(postId);
    await postRef.collection('comment').add(comment.toJson());
    await postRef.update({
      'commentCount': FieldValue.increment(1),
    });
  }
}
