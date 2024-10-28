import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/presentation/stroy/bloc/story_bloc.dart';
import 'package:untitled11/presentation/stroy/page/story_page.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/resources/values_manager.dart';
import 'package:untitled11/presentation/unit/chimmer/loading_chimmer_widget.dart';
import 'package:untitled11/presentation/unit/image.dart';
class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  SizedBox(
      height: size.height*0.092,
      width: double.infinity,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical:8 ),
        child: Container(
          margin: EdgeInsets.all(AppPadding.p2),
          padding: EdgeInsets.only(left: AppPadding.p10,top: AppPadding.p2,bottom: AppPadding.p2),
          //    height: AppSize.s150,
          decoration: BoxDecoration(
            color: ColorManager.storyColor,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppSize.s15)),
            //        color: ColorManager.card,
          ),
          child: BlocBuilder<StoryBloc, StoryState>(
            buildWhen: (previous, current) {
              return current is StoryLoadingState ||current is StoryState||current is StoryErrorState;
            },
  builder: (context, state) {
    if(state is StoryErrorState){
      return Text("some things want wrong");
    }
    if(state is StoryLoadingState){
      return LoadingChimmerWidget();
    }
    if(state is StorySucState){
      List<StoryModel> stories=state.storyModel.stories;

      BlocProvider.of<StoryBloc>(context).add(SetStorySql(stories));
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StoryPage(storyModel: stories[index],sql: state.storyModel.sql)));
              },
              child: Container(
                width: size.height*0.068,
                height: size.height*0.068,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: CircularImage(height: size.height*0.068,
                    width: size.height*0.06, image:stories[index].userModel.image,sql: state.storyModel.sql,)
            ),
            );
          },
          itemCount: stories.length);
    }
    if(state is StorySqlSucState){
      List<StoryModel> stories=state.storyModel.stories;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StoryPage(storyModel: stories[index],sql: state.storyModel.sql)));
              },
              child: Container(
                  width: size.height*0.068,
                  height: size.height*0.068,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: CircularImage(height: size.height*0.068,
                      width: size.height*0.06, image:stories[index].userModel.image,sql: state.storyModel.sql)
              ),
            );
          },
          itemCount: stories.length);
    }
   return SizedBox();
  },
),
        ),
      ),
    );
  }
}
