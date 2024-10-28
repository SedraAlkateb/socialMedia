

import 'package:dartz/dartz.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:equatable/equatable.dart';
class GetStoryUsecase extends Equatable {
  final RepositoryFirebase _repositoryFirebase;
  GetStoryUsecase(this._repositoryFirebase);
  Future<Either<Failure, StoriesModel>> execute() async{
    return await _repositoryFirebase.getStories();
  }
  @override
  List<Object?> get props => [_repositoryFirebase];

}


