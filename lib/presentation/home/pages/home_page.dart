import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/presentation/home/bloc/home_bloc.dart';
import 'package:untitled11/presentation/post/page/comment_widget.dart';
import 'package:untitled11/presentation/post/widget/field_comment.dart';
import 'package:untitled11/presentation/post/page/posts.dart';
import 'package:untitled11/presentation/post/bloc/post_bloc.dart';
import 'package:untitled11/presentation/stroy/widget/story.dart';
import 'package:untitled11/presentation/resources/assets_manager.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/unit/chimmer/loading_chimmer_widget.dart';
import 'package:untitled11/presentation/unit/stateWidget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(ImageAssets.socially),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(ImageAssets.notification)),
        ),
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<PostBloc, PostState>(
          listenWhen: (previous, current) {
            return current is CommentState ||
                current is CommentErrorState ||
                current is CommentLoadingState||
            current is CommentSucState;
          },
          listener: (context, state) {
            if (state is CommentLoadingState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.3,
                      maxChildSize: 0.8,
                      expand: false,
                      builder: (context, scrollController) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  color: ColorManager.mainColor,
                                  height: 3,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: LoadingChimmerWidget(),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              });
            } else if (state is CommentErrorState) {
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.3,
                      maxChildSize: 0.8,
                      expand: false,
                      builder: (context, scrollController) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  color: ColorManager.mainColor,
                                  height: 3,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: fullScreenError(
                                  context,
                                  state.failure.massage,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              });
            } else if (state is CommentState) {
              BlocProvider.of<PostBloc>(context).add(EditPostCont(state.index));
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  color: ColorManager.mainColor,
                                  height: 3,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.commentModel.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var comment = state.commentModel[index];
                                    return ListTile(
                                      title: CommentWidget(comment: comment),
                                    );
                                  },
                                ),
                              ),
                              FieldComment(
                                commentController: _commentController,
                                postId: state.postId,
                                comments: state.commentModel,
                                index: state.index,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              });
            } else if (state is CommentSucState) {
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  color: ColorManager.mainColor,
                                  height: 3,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.commentModel.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var comment = state.commentModel[index];
                                    return ListTile(
                                      title: CommentWidget(comment: comment),
                                    );
                                  },
                                ),
                              ),
                              FieldComment(
                                commentController: _commentController,
                                postId: state.postId,
                                comments: state.commentModel,
                                index: state.index,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              });
            }
          },


          builder: (context, state) =>
              
              SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StoryWidget(),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      List<PostModel> posts=context.watch<PostBloc>().posts;
                      if (state is PostErrorState) {
                        return fullScreenError(context, state.failure.massage);
                      }
                      if (state is PostLoadingState) {
                        return LoadingChimmerWidget();
                      }
                      if (state is PostSucState) {
                        BlocProvider.of<PostBloc>(context).add(SetPostSql(posts));
                        posts = state.postModel.posts;

                      }
                      if(state is PostSqlSucState){
                        posts = state.postModel.posts;
                      }
                      if(state is PostEditSucState){
                        posts=state.posts;
                      }
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Posts(
                                postModel: posts[index],
                                index: index,
                                sql: context.watch<PostBloc>().sql,
                              );
                            },
                            itemCount: posts.length);

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
