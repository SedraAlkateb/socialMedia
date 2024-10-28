

import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:equatable/equatable.dart';
class SetCommentUsecase extends Equatable {
  final RepositoryFirebase _repositoryFirebase;
  const SetCommentUsecase(this._repositoryFirebase);
  Future<Either<Failure, Null>> execute(String postId, CommentAdd comment) async{
    return await _repositoryFirebase.setComment(postId, comment);
  }
  @override
  List<Object?> get props => [_repositoryFirebase];

}


