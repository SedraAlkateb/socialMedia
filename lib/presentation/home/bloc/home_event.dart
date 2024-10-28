part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable{

}

class ChangeTapNav extends HomeEvent{
  final int index;
  ChangeTapNav({required this.index});
  @override
  List<Object?> get props =>[index];
}
