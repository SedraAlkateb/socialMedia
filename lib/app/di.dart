import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:untitled11/data/network/app_sql_api.dart';
import 'package:untitled11/data/network/firebase_api.dart';
import 'package:untitled11/data/network/firebase_factory.dart';
import 'package:untitled11/data/network/network_info.dart';
import 'package:untitled11/data/network/sqlite_factory.dart';
import 'package:untitled11/data/repository/repositroy_firebase.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled11/domain/repostitory/repository_firebase.dart';
import 'package:untitled11/domain/usecase/get_Comment_usecase.dart';
import 'package:untitled11/domain/usecase/get_post_usecase.dart';
import 'package:untitled11/domain/usecase/get_story_usecase.dart';
import 'package:untitled11/domain/usecase/insert_post_sql_usecase.dart';
import 'package:untitled11/domain/usecase/insert_story_sql_usecase.dart';
import 'package:untitled11/domain/usecase/set_comment_usecase.dart';
import 'package:untitled11/presentation/post/bloc/post_bloc.dart';
import 'package:untitled11/presentation/stroy/bloc/story_bloc.dart';

GetIt instance = GetIt.instance;
Future<void> initAppModule() async {
  DatabaseHelper databaseHelper = DatabaseHelper();
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl((InternetConnection())));
  instance.registerLazySingleton<AppSqlApi>(() => AppSqlApi(databaseHelper));
  FirebaseService firebaseService = FirebaseService();
  instance.registerLazySingleton<FirebaseApi>(() => FirebaseApi(firebaseService));
  instance.registerLazySingleton<RepositoryFirebase>(() => RepositroyFirebaseImp(instance(),instance(),instance()));
}
Future<void> initPostModule() async {
  if (!GetIt.I.isRegistered<GetPostUsecase>()) {
    instance.registerFactory<GetPostUsecase>(() => GetPostUsecase(instance()));
    instance.registerFactory<GetCommentUsecase>(() => GetCommentUsecase(instance()));
    instance.registerFactory<SetCommentUsecase>(() => SetCommentUsecase(instance()));
    instance.registerFactory<InsertPostSqlUsecase>(() => InsertPostSqlUsecase(instance()));
    instance.registerFactory<PostBloc>(() => PostBloc(instance(),instance(),instance()
        ,instance() ));
  }
}

Future<void> initStoryModule() async {
  if (!GetIt.I.isRegistered<GetStoryUsecase>()) {
    instance.registerFactory<GetStoryUsecase>(() => GetStoryUsecase(instance()));
    instance.registerFactory<InsertStorySqlUsecase>(() => InsertStorySqlUsecase(instance()));
    instance.registerFactory<StoryBloc>(() => StoryBloc(instance(),instance()));
  }
}