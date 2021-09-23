import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/comment_state.dart';
import 'package:my_blog/models/comment.dart';
import 'package:my_blog/services/comment_api_provider.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentProvider commentProvider;

  CommentCubit(this.commentProvider) : assert(commentProvider != null), super(CommentLoadingState());

  Future<void> fetchCommentsFromPost(int id) async {
    try {
      emit(CommentLoadingState());
      final List<Comment> _loadedCommentList = await commentProvider.getCommentsFromPost(id);
      emit(CommentsAllLoadedState(loadedComment: _loadedCommentList));
    } catch (_) {
      emit(CommentErrorState());
    }
  }

  Future<void> sendCommentToPost(Comment comment) async {
    try {
      //
      await commentProvider.postCommentToPost(comment);
      //
    } catch (_) {
      //
    }
  }
}