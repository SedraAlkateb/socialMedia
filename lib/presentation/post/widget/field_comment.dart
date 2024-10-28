import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/presentation/post/bloc/post_bloc.dart';

class FieldComment extends StatelessWidget {
   FieldComment({super.key,required this.commentController,
     required this.postId,
     required this.comments,
     required this.index
   });
  final TextEditingController commentController;
  String postId;
  int index;
  List<Comment> comments;
  @override
  Widget build(BuildContext context) {
    return    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "اكتب تعليقًا...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      print("تم إدخال التعليق: $value");
                      commentController.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    CommentAdd comment = CommentAdd(
                      content: commentController.text,
                    );
                    BlocProvider.of<PostBloc>(context)
                        .add(AddCommentEvent(comment, postId,index));
                    print("تم إرسال التعليق: ${commentController.text}");
                    commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
