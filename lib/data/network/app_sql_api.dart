import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:untitled11/data/network/sqlite_factory.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:sqflite/sqflite.dart';
abstract class AppSqlApiAbs{

}
class AppSqlApi extends AppSqlApiAbs {
  DatabaseHelper databaseHelper;
  Set<String> userIds = {};
  AppSqlApi(this.databaseHelper);

  insertPost(PostsModel posts) async {
    Database? mydb = await databaseHelper.database;

    Batch batch = mydb.batch();
    batch.delete('post_image');
    batch.delete('post');
    for (var post in posts.posts) {
      if (!userIds.contains(post.userModel.id)) {
        post.userModel.image =await convertImageUrlToBase64(post.userModel.image);
        await mydb.insert(
          'user',
          post.userModel.toJsonSql(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        userIds.add(post.userModel.id);
      }
      batch.insert('post', post.toJsonSql());
      if (post.images != null && post.images!.isNotEmpty) {
        for (var imageUrl in post.images!) {
          imageUrl =await convertImageUrlToBase64(imageUrl);
          batch.insert('post_image', {
            'image': imageUrl,
            'postId': post.id,
          });
        }
      }
    }
    await batch.commit(noResult: true);
  }
  insertStory(StoriesModel stories) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
     batch.delete('story_image');
     batch.delete('story');
    for (var story in stories.stories) {
      if (!userIds.contains(story.userModel.id)) {
        story.userModel.image =await convertImageUrlToBase64(story.userModel.image);
        await mydb.insert('user',
            story.userModel.toJsonSql(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        userIds.add(story.userModel.id);
      }
      batch.insert('story', story.toJsonSql());
      if (story.images.isNotEmpty) {
        for (var imageUrl in story.images) {
          imageUrl =await convertImageUrlToBase64(imageUrl);
          batch.insert('story_image', {
            'image': imageUrl,
            'storyId': story.id,
          });
        }
      }
    }
    await batch.commit(noResult: true);
  }
 Future<PostsModel> getPosts() async {
    Database? mydb = await databaseHelper.database;
    final List<Map<String, dynamic>> postMaps = await mydb.query('post');
    List<PostModel> posts = [];
    for (var postMap in postMaps) {
      final List<Map<String, dynamic>> imageMaps = await mydb.query(
        'post_image',
        where: 'postId = ?',
        whereArgs: [postMap['postId']],
      );
      List<String> images = imageMaps.map((imageMap) => imageMap['image'] as String).toList();
      final List<Map<String, dynamic>> userMaps = await mydb.query(
        'user',
        where: 'userId = ?',
        whereArgs: [postMap['userId']],
      );
      PostModel post = PostModel.fromJsonSql(postMap, userMaps.first, images);
      posts.add(post);
    }
    return PostsModel(posts, 1);
  }
  Future<StoriesModel> getStories() async {
    Database? mydb = await databaseHelper.database;
    final List<Map<String, dynamic>> storyMaps = await mydb.query('story');
    List<StoryModel> stories = [];
    for (var storyMap in storyMaps) {
      final List<Map<String, dynamic>> imageMaps = await mydb.query(
        'story_image',
        where: 'storyId = ?',
        whereArgs: [storyMap['storyId']],
      );

    List<String> images = imageMaps.map((imageMap) => imageMap['image']as String).toList();
      final List<Map<String, dynamic>> userMaps = await mydb.query(
        'user',
        where: 'userId = ?',
        whereArgs: [storyMap['userId']],
      );
      StoryModel story = StoryModel.fromJsonSql(storyMap, userMaps.first, images);
      stories.add(story);
    }
    return StoriesModel(stories, 1);
  }
  Future<UserModel> getUser(String userId)async{
    Database? mydb = await databaseHelper.database;

    final List<Map<String, dynamic>> user = await mydb.query(
      'user',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return UserModel.fromJson(user.first, userId);
  }
  Future<String> convertImageUrlToBase64(String imageUrl) async {
    final ByteData bytes = await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
    final Uint8List imageData = bytes.buffer.asUint8List();
    return base64Encode(imageData);
  }

}