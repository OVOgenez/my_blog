import 'package:flutter/foundation.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentsAllLoadedState extends CommentState {
  List<dynamic> loadedComment;
  CommentsAllLoadedState({@required this.loadedComment}) : assert(loadedComment != null);
}

class CommentErrorState extends CommentState {}