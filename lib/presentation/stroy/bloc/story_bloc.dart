import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/domain/usecase/get_story_usecase.dart';
import 'package:untitled11/domain/usecase/insert_story_sql_usecase.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  GetStoryUsecase getStoryUsecase;
  InsertStorySqlUsecase insertStorySqlUsecase;
  StoryBloc(
      this.getStoryUsecase,
      this.insertStorySqlUsecase

      ) : super(StoryInitial()) {
    on<StoryEvent>((event, emit)async {
      if(event is StoriesEvent){
        emit(StoryLoadingState());
        (await getStoryUsecase.execute()).fold((failure) {
      emit(StoryErrorState(failure: failure));
      }, (data) async {
     if(data.sql==0){
       emit(StorySucState(data));
     }else{
       emit(StorySqlSucState(data));
     }

      });
    }
      if(event is SetStorySql){
        (await insertStorySqlUsecase.execute(StoriesModel(event.stories, 0))).fold((failure) {
       //   emit(StoryErrorState(failure: failure));
        }, (data) async {
        });
      }
    });
  }
}
