import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/comment_cubit.dart';
import 'package:my_blog/cubit/comment_state.dart';

class CommentList extends StatelessWidget {
  final int postId;
  bool _fisrtStart = true;

  CommentList(this.postId);

  @override
  Widget build(BuildContext context) {
    final CommentCubit commentCubit = context.watch<CommentCubit>();

    if (_fisrtStart) {
      commentCubit.fetchCommentsFromPost(postId);
      _fisrtStart = !_fisrtStart;
    }

    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CommentsAllLoadedState) {
          return RefreshIndicator(
            child: ListView.separated(
              itemCount: state.loadedComment.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) => Container(
                color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                child: ListTile(
                  leading: Column(
                    children: [
                      Icon(Icons.face),
                      Text(
                        'id ${state.loadedComment[index].id}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  title: Text(
                    '${state.loadedComment[index].user}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${state.loadedComment[index].body}',
                    style: TextStyle(fontSize: 18),
                    softWrap: true,
                  ),
                ),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () async {
              commentCubit.fetchCommentsFromPost(postId);
            },
          );
        }

        if (state is CommentErrorState) {
          return RefreshIndicator(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'Error fetching comments',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
              physics: const AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () async {
              commentCubit.fetchCommentsFromPost(postId);
            },
          );
        }

        return null;
      },
    );
  }
}
