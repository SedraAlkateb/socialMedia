import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/presentation/post/bloc/post_bloc.dart';
import 'package:untitled11/presentation/resources/assets_manager.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/resources/values_manager.dart';
import 'package:untitled11/presentation/unit/image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled11/presentation/unit/slider_iamge.dart';
import 'package:timeago/timeago.dart' as timeago;

class Posts extends StatelessWidget {
  const Posts({super.key,required this.postModel,required this.index,required this.sql});
  final PostModel postModel;
  final int index;
  final int sql;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Container(
      margin: EdgeInsets.all( AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.s20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
                  children: [
                    CircularImage(height: 25, width: 24, image:postModel.userModel.image,sql:sql ,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      child: Text(
                        postModel.userModel.name,style: Theme.of(context).textTheme.titleSmall,),
                    )
                  ],
                ),
                  Text( timeago.format(postModel.timestamp))
                   ],
              ),
            ),

            SizedBox(height: (postModel.images!=null&&postModel.images!.isNotEmpty)?9:0),
            (postModel.images!=null&&postModel.images!.isNotEmpty)?
            ImageSlider(imageUrls: postModel.images??[],sql: sql,):SizedBox(),
            SizedBox(height: postModel.desc!=null? 9:0,),
            postModel.desc!=null?
            Text(postModel.desc!):SizedBox(),
            SizedBox(height: postModel.desc!=null? 8:0,),
            Divider(),
            Padding(
              padding:  EdgeInsets.only(left: AppPadding.p10,top: 15,bottom: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(ImageAssets.favoriteBorder),
                      SizedBox(width: 8,),
                      Text(postModel.favorite.toString()),
                      SizedBox(width: 8,),
                      BlocBuilder<PostBloc, PostState>(
  builder: (context, state) {
    return InkWell(
                        onTap: () {
                      state is CommentLoadingState?null:BlocProvider.of<PostBloc>(context).add(CommentsEvent(postModel.id,index));
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageAssets.comment),
                            SizedBox(width: 8,),
                            Text((postModel.commentCount).toString()),
                          ],
                        ),
                      );
  },
),


                    ],
                  ),
                  SvgPicture.asset(ImageAssets.box)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
