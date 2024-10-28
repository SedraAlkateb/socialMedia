

import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:equatable/equatable.dart';
class GetPostUsecase extends Equatable {
  final RepositoryFirebase _repositoryFirebase;
  GetPostUsecase(this._repositoryFirebase);
  Future<Either<Failure,PostsModel>> execute( ) async{
    return await _repositoryFirebase.getPosts( );
  }
  @override
  List<Object?> get props => [_repositoryFirebase];

}


