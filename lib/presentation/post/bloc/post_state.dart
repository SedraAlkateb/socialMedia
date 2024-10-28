part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}


final class UserInfoState extends PostState {
  final UserModel userModel;
  UserInfoState(this.userModel);
  @override
  List<Object?> get props =>[userModel];
}
final class UserInfoErrorState extends PostState {
  final Failure failure;
  UserInfoErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class UserInfoLoadingState extends PostState {
  @override
  UserInfoLoadingState();
  @override
  List<Object?> get props =>[];
}

final class PostSucState extends PostState {
  final PostsModel postModel;
  PostSucState(this.postModel);
  @override
  List<Object?> get props =>[postModel];
}
final class PostSqlSucState extends PostState {
  final PostsModel postModel;
  PostSqlSucState(this.postModel);
  @override
  List<Object?> get props =>[postModel];
}
final class PostEditSucState extends PostState {
  final List<PostModel> posts;
  PostEditSucState(this.posts);
  @override
  List<Object?> get props =>[posts];
}
final class PostErrorState extends PostState {
  final Failure failure;
  PostErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class PostLoadingState extends PostState {
  @override
  PostLoadingState();
  @override
  List<Object?> get props =>[];
}
final class CommentState extends PostState {
  final List<Comment> commentModel;
  String postId;
  int index;
  CommentState(this.commentModel,this.postId,this.index);
  @override
  List<Object?> get props =>[commentModel];
}
final class CommentSucState extends PostState {
  final List<Comment> commentModel;
  final String postId;
  final int index;
  CommentSucState(this.commentModel,this.postId,this.index);
  @override
  List<Object?> get props =>[commentModel];
}
final class CommentErrorState extends PostState {
  final Failure failure;
  CommentErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class CommentLoadingState extends PostState {
  String postId;
  @override
  CommentLoadingState(this.postId);
  @override
  List<Object?> get props =>[];
}
final class AddCommentState extends PostState {

  @override
  List<Object?> get props =>[];
}
final class AddCommentErrorState extends PostState {
  final Failure failure;
  AddCommentErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AddCommentLoadingState extends PostState {
  @override
  AddCommentLoadingState();
  @override
  List<Object?> get props =>[];
}
