import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
class InsertStorySqlUsecase extends Equatable {
  final RepositoryFirebase _repositorySql;
  const InsertStorySqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(StoriesModel stories) async{
    return await _repositorySql.insertStory(stories);
  }
  @override
  List<Object?> get props => [_repositorySql];

}




