import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/post_cubit.dart';
import 'package:my_blog/cubit/post_state.dart';
import 'package:my_blog/pages/comments_page.dart';

class PostList extends StatelessWidget {
  bool _fisrtStart = true;

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = context.watch<PostCubit>();

    if (_fisrtStart) {
      postCubit.fetchAllPosts();
      _fisrtStart = !_fisrtStart;
    }

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostsAllLoadedState) {
          return ListView.separated(
            itemCount: state.loadedPost.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) => Container(
              color: index % 2 == 0 ? Colors.white : Colors.blue[50],
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CommentsPage(state.loadedPost[index])),
                  );
                },
                child: ListTile(
                  leading: Column(
                    children: [
                      Icon(Icons.comment),
                      Text(
                        'id ${state.loadedPost[index].id}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  title: Text(
                    '${state.loadedPost[index].title}',
                    style: TextStyle(fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${state.loadedPost[index].body}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text('${state.loadedPost[index].user}'),
                ),
              ),
            ),
          );
        }

        if (state is PostErrorState) {
          return Center(
            child: Text(
              'Error fetching users',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        return null;
      },
    );
  }
}
