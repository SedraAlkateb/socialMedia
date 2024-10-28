import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:untitled11/app/user_info.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/usecase/get_Comment_usecase.dart';
import 'package:untitled11/domain/usecase/get_post_usecase.dart';
import 'package:untitled11/domain/usecase/insert_post_sql_usecase.dart';
import 'package:untitled11/domain/usecase/set_comment_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/domain/models/models.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  GetPostUsecase getPostUsecase;
  GetCommentUsecase getCommentUsecase;
  SetCommentUsecase setCommentUsecase;
  InsertPostSqlUsecase insertPostSqlUsecase;
  List<PostModel> posts=[];
  List<Comment> comments=[];
  int sql=0;
  PostBloc(
      this.getPostUsecase,
      this.getCommentUsecase,
      this.setCommentUsecase,
      this.insertPostSqlUsecase
      ) : super(PostInitial()) {
    on<PostEvent>((event, emit)async {
      if(event is PostsEvent){
        emit(PostLoadingState());
        (await getPostUsecase.execute()).fold((failure) {
      emit(PostErrorState(failure: failure));
      }, (data) async {
          posts=data.posts;
          sql=data.sql;
          if(data.sql==0){

            emit(PostSucState(data));
          }else{
            emit(PostSqlSucState(data));
          }
      });
      }
      if(event is AddCommentEvent){
      print("object");
      emit(AddCommentLoadingState());
      (await setCommentUsecase.execute(event.postId,event.comment)).fold((failure) {
      print(failure.massage);
      emit(AddCommentErrorState(failure: failure));
      }, (data) async {
        List<Comment> comment2= List.from(comments);
        comment2.add(
            Comment(id: "", content:event.comment.content  , timestamp: DateTime.now(),
                userModel: UserModel(id: UserInfo.userId, name: UserInfo.name, image: UserInfo.image)));
        comments = comment2;

      emit(CommentState(comment2,event.postId,event.index));
      });
      }
      if(event is EditPostCont){
        List<PostModel> posts1=List.from(posts);
        posts1[event.index].commentCount!=posts[event.index].commentCount+1;
        posts=posts1;
        emit(PostEditSucState(posts));
      }
      if(event is CommentsEvent){
      emit(CommentLoadingState(event.id));
      (await getCommentUsecase.execute(event.id)).fold((failure) {
      emit(CommentErrorState(failure: failure));
      }, (data) async {
        comments=data;
      emit(CommentSucState(data,event.id,event.index));
      });
      }
      if(event is SetPostSql){
        (await insertPostSqlUsecase.execute(PostsModel(posts, 0))).fold((failure) {
         // emit(PostErrorState(failure: failure));
        }, (data) async {
        });
      }

    });
  }
}
