import 'package:flutter/foundation.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostsAllLoadedState extends PostState {
  List<dynamic> loadedPost;
  PostsAllLoadedState({@required this.loadedPost}) : assert(loadedPost != null);
}

class PostErrorState extends PostState {}