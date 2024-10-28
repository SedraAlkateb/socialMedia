part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {}


final class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class IndexTabNavChanged extends HomeState{
  final int index;
  IndexTabNavChanged({required this.index});
  @override
  List<Object?> get props => [index];

}