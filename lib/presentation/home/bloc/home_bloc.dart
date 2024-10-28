import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int index=0;

  HomeBloc(

      ) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async{
      // if(event is UserInfoEvent){
      //   (await getUserUsecase.execute(event.userId)).fold((failure) {
      //     emit(UserInfoErrorState(failure: failure));
      //   }, (data) async {
      //     print(data.name);
      //     emit(UserInfoState(data));
      //   });
      // }

      if (event is ChangeTapNav) {
        index = event.index;
        emit(IndexTabNavChanged(index: index));
      }
    });
  }
}
