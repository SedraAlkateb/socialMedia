

import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:equatable/equatable.dart';
class GetUserUsecase extends Equatable {
  final RepositoryFirebase _repositoryFirebase;
  GetUserUsecase(this._repositoryFirebase);
  Future<Either<Failure, UserModel>> execute(String userId ) async{
    return await _repositoryFirebase.getUserData( userId);
  }
  @override
  List<Object?> get props => [_repositoryFirebase];

}


