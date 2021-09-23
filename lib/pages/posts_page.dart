import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/post_cubit.dart';
import 'package:my_blog/services/post_api_provider.dart';
import 'package:my_blog/widgets/post_list.dart';

class PostsPage extends StatelessWidget {
  final postProvider = PostProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => PostCubit(postProvider),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Post list'),
          centerTitle: true,
        ),
        body: PostList(),
      ),
    );
  }
}
