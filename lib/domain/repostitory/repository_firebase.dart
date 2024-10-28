import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';

abstract class RepositoryFirebase {
  Future<Either<Failure,UserModel>> getUserData(String userId) ;
  Future<Either<Failure,PostsModel>> getPosts() ;
  Future<Either<Failure,StoriesModel>> getStories() ;
  Future<Either<Failure,List<Comment>>> getComment(String id) ;
  Future<Either<Failure,Null>> setComment(String postId,CommentAdd comment) ;
  Future<Either<Failure,Null>> insertStory(StoriesModel stories) ;
  Future<Either<Failure,Null>> insertPost(PostsModel posts) ;
  Future<Either<Failure,UserModel>> getUser(String userId) ;



}