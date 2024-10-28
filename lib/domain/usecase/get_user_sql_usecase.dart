import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
class GetUserSqlUsecase extends Equatable {
  final RepositoryFirebase _repositorySql;
  const GetUserSqlUsecase(this._repositorySql);
  Future<Either<Failure, UserModel >> execute(String userId) async{
    return await _repositorySql.getUser(userId);
  }
  @override
  List<Object?> get props => [_repositorySql];

}




