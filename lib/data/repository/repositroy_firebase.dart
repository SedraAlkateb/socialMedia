import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/app_sql_api.dart';
import 'package:untitled11/data/network/error_handler.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/data/network/firebase_api.dart';
import 'package:untitled11/data/network/network_info.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';

class RepositroyFirebaseImp extends RepositoryFirebase {
  final FirebaseApi _firebaseApi;
  final NetworkInfo _networkInfo;
  final AppSqlApi _databaseHelper;

  RepositroyFirebaseImp(this._firebaseApi,this._networkInfo,this._databaseHelper);

  @override
  Future<Either<Failure, UserModel>> getUserData(String userId)async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _firebaseApi.getUserData(userId);
        return Right(response);
      }
      else {
        final response = await _databaseHelper.getUser(userId);
        return Right(response);
      }
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, PostsModel>> getPosts() async {

    try {
      if(await _networkInfo.isConnected){
        final response = await _firebaseApi.getPosts();
        return Right(response);
      }else{
        final response = await _databaseHelper.getPosts();
        return Right(response);
      }

    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, StoriesModel>> getStories() async {
    try {
      if(await _networkInfo.isConnected) {
        final response = await _firebaseApi.getStories();
        return Right(response);
      }else{
        final response = await _databaseHelper.getStories();
        return Right(response);
      }
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComment(String id) async {
    try {
      final response = await _firebaseApi.getComment(id);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> setComment(String postId, CommentAdd comment)  async {
    try {
       await _firebaseApi.setComment(postId, comment);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPost(PostsModel posts) async {
    try {
      final response = await _databaseHelper.insertPost(posts);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertStory(StoriesModel stories)async {
    try {
      final response = await _databaseHelper.insertStory(stories);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String userId)async {
    try {
      final response = await _databaseHelper.getUser(userId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

}
