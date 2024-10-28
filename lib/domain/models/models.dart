import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled11/app/user_info.dart';
class UserModel {
  final String id;
  final String name;
   String image;
  UserModel({required this.id, required this.name, required this.image});
  factory UserModel.fromJson(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
  factory UserModel.fromJsonSql(Map<String, dynamic> data) {
    return UserModel(
      id: data['userId'],
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
  Map<String, dynamic> toJsonSql() {
    return {
      'userId':id,
      'name': name,
      'image':image,
    };
  }
}

class PostsModel{
  List<PostModel> posts;
  int sql;
  PostsModel(this.posts,this.sql);
}
class StoriesModel{
  List<StoryModel> stories;
  int sql;
  StoriesModel(this.stories,this.sql);
}
class PostModel {
  final String id;
  final String? desc;
  final List<String>? images;
  final int favorite;
  final DateTime timestamp;
  final List<Comment>? comments;
  final UserModel userModel;
  final int commentCount;
  PostModel({
    required this.id,
    this.desc,
    this.images,
    required this.favorite,
    required this.timestamp,
    this.comments,
    required this.userModel,
    required this.commentCount,
  });

  factory PostModel.fromJson( Map<String, dynamic> data,
      Map<String, dynamic> dataUser, String postId, String userId) {
    return PostModel(
        id: postId,
        commentCount: data['commentCount'],
        desc: data['desc'] ?? '',
        images: data['images'] != null
            ? List<String>.from(jsonDecode(data['images']))
            : [],
        favorite: data['favorite'] ?? 0,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
      //  comments: comments,
        userModel: UserModel.fromJson(dataUser, userId)

    );
  }

  factory PostModel.fromJsonSql( Map<String, dynamic> data,
      Map<String, dynamic> dataUser, List<String> images ) {
    return PostModel(
        id:  data['postId'],
        commentCount: data['commentCount'],
        desc: data['desc'] ?? '',
        images: images,
        favorite: data['favorite'] ?? 0,
        timestamp: DateTime.parse(data['timestamp']),
        userModel: UserModel.fromJsonSql(dataUser)

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentCount':commentCount,
      'postId': id,
      'desc': desc,
      'images': images,
      'favorite': favorite,
      'timestamp': timestamp,
      'comments': comments?.map((comment) => comment.toJson()).toList(),
      'users': userModel.toJson()
    };
  }
  Map<String, dynamic> toJsonSql() {
    return {
      'commentCount':commentCount,
      'postId': id,
      'desc': desc,
      'favorite': favorite,
      'timestamp': timestamp.toIso8601String(),
      'userId': userModel.id
    };
  }
}

class Comment {
  final String id;
  final String content;
  final DateTime timestamp;
  final UserModel userModel;

  Comment({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.userModel,
  });

  factory Comment.fromJson(Map<String, dynamic> dataUser,Map<String, dynamic> data, String id, String userId) {
    print(data);
    return Comment(
      id: id,
      content: data['desc'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
        userModel: UserModel.fromJson(dataUser, userId)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': id,
      'commentText': content,
      'timestamp': timestamp,
      'userId': userModel.toJson(),
    };
  }
}

class CommentAdd {
  final String content;
   Timestamp? timestamp;
   String? userId;
  CommentAdd({
    required this.content,
  });
  Map<String, dynamic> toJson() {
    return {
      'desc': content,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': UserInfo.userId
    };
  }
}

class StoryModel {
  final String id;
  final List<String> images;
  final UserModel userModel;
  StoryModel({required this.id, required this.images, required this.userModel});
  factory StoryModel.fromJsonSql( Map<String, dynamic> data,
      Map<String, dynamic> dataUser, List<String> images ) {
    return StoryModel(
        id:  data['storyId'],
        images: images,
        userModel: UserModel.fromJsonSql(dataUser)

    );
  }

  factory StoryModel.fromJson(Map<String, dynamic> dataStory,
      Map<String, dynamic> dataUser, String storyId, String userId) {
    return StoryModel(
        id: storyId,
        images: dataStory['images'] != null
            ? List<String>.from(jsonDecode(dataStory['images']))
            : [],
        userModel: UserModel.fromJson(dataUser, userId));
  }

  Map<String, dynamic> toJson() {
    return {
      'storyId': id,
      'images': images,
      'userModel': userModel.toJson(),
    };
  }
  Map<String, dynamic> toJsonSql() {
    return {
      'storyId': id,
      'userId': userModel.id,
    };
  }
}
