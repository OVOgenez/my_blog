import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/post_state.dart';
import 'package:my_blog/models/post.dart';
import 'package:my_blog/services/post_api_provider.dart';

class PostCubit extends Cubit<PostState> {
  final PostProvider postProvider;

  PostCubit(this.postProvider) : assert(postProvider != null), super(PostLoadingState());

  Future<void> fetchAllPosts() async {
    try {
      emit(PostLoadingState());
      final List<Post> _loadedPostList = await postProvider.getAllPosts();
      emit(PostsAllLoadedState(loadedPost: _loadedPostList));
    } catch (_) {
      emit(PostErrorState());
    }
  }
}