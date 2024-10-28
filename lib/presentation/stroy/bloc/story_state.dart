part of 'story_bloc.dart';

@immutable
abstract class StoryState extends Equatable{}

final class StoryInitial extends StoryState {
  @override
  List<Object?> get props => [];
}
final class StorySucState extends StoryState {
  final StoriesModel storyModel;
  StorySucState(this.storyModel);
  @override
  List<Object?> get props =>[storyModel];
}
final class StorySqlSucState extends StoryState {
  final StoriesModel storyModel;
  StorySqlSucState(this.storyModel);
  @override
  List<Object?> get props =>[storyModel];
}

final class StoryErrorState extends StoryState {
  final Failure failure;
  StoryErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class StoryLoadingState extends StoryState {
  @override
  StoryLoadingState();
  @override
  List<Object?> get props =>[];
}