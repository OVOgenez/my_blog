import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/comment_cubit.dart';
import 'package:my_blog/models/comment.dart';

class CommentField extends StatelessWidget {
  Comment comment;

  CommentField(this.comment);

  @override
  Widget build(BuildContext context) {
    final CommentCubit commentCubit = context.watch<CommentCubit>();

    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Name",
            ),
            onChanged: (text) {
              comment.user = text;
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    hintText: "Comment",
                  ),
                  onChanged: (text) {
                    comment.body = text;
                  },
                ),
              ),
              ElevatedButton(
                child: Text('Send'),
                onPressed: () {
                  commentCubit.sendCommentToPost(comment);
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
