import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:untitled11/domain/models/models.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/resources/values_manager.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

   CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile image
          CircleAvatar(
            backgroundColor: ColorManager.filedColor,
            radius: 20,
            backgroundImage: NetworkImage(
              comment.userModel.image,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                border: Border.all(
                  color: ColorManager.mainColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User name and time ago
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment.userModel.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeago.format(comment.timestamp),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  // Comment content text
                  Text(
                    comment.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
