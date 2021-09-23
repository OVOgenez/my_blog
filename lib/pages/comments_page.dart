import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/comment_cubit.dart';
import 'package:my_blog/models/post.dart';
import 'package:my_blog/services/comment_api_provider.dart';
import 'package:my_blog/widgets/comment_list.dart';

class CommentsPage extends StatelessWidget {
  final commentProvider = CommentProvider();
  final Post post;

  CommentsPage(this.post);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => CommentCubit(commentProvider),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Comments List'),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.comment_outlined),
                        Text('${post.user}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      post.title + '\n\n' + post.body,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Divider(height: 1),
              Expanded(
                child: CommentList(post.id),
              ),
            ],
          )),
    );
  }
}
