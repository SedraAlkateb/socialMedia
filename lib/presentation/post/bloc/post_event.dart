part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable{}
final class CommentsEvent extends PostEvent{
  final String id;
  final  int index;
  CommentsEvent(this.id,this.index);
  @override
  List<Object?> get props => [id];
}
final class EditPostCont extends PostEvent{
  final  int index;
  EditPostCont(this.index);
  @override
  List<Object?> get props => [];
}

final class AddCommentEvent extends PostEvent{
  final CommentAdd comment;
  final String postId;
  final int index;
  AddCommentEvent(this.comment,this.postId,this.index);
  @override
  List<Object?> get props => [comment,postId];
}
final class PostsEvent extends PostEvent{
  @override
  List<Object?> get props => [];
}

final class UserInfoEvent extends PostEvent{
  @override
  final String userId;
  UserInfoEvent(this.userId);
  List<Object?> get props => throw UnimplementedError();

}
final class SetPostSql extends PostEvent{
  final List<PostModel> posts;
  SetPostSql(this.posts);
  @override
  List<Object?> get props => [posts];
}