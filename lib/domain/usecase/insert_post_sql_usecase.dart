import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
class InsertPostSqlUsecase extends Equatable {
  final RepositoryFirebase _repositorySql;
  const InsertPostSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(PostsModel posts) async{
    return await _repositorySql.insertPost(posts);
  }
  @override
  List<Object?> get props => [_repositorySql];

}




