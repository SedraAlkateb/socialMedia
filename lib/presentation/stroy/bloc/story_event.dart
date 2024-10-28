part of 'story_bloc.dart';

@immutable
sealed class StoryEvent extends Equatable{

}
final class StoriesEvent extends StoryEvent{
  @override
  List<Object?> get props => [];
}
final class SetStorySql extends StoryEvent{
 final List<StoryModel> stories;
  SetStorySql(this.stories);
  @override
  List<Object?> get props => [stories];
}