

import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:equatable/equatable.dart';
class GetCommentUsecase extends Equatable {
  final RepositoryFirebase _repositoryFirebase;
  const GetCommentUsecase(this._repositoryFirebase);
  Future<Either<Failure, List<Comment>>> execute( String id) async{
    return await _repositoryFirebase.getComment(id);
  }
  @override
  List<Object?> get props => [_repositoryFirebase];

}


