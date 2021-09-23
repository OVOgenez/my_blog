import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_blog/models/comment.dart';

class CommentProvider {
  Future<List<Comment>> getCommentsFromPost(int id) async {
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/${id}/comments'));

    print('GET: ${json.decode(responce.body)}');

    if (responce.statusCode == 200) {
      final List<dynamic> postJson = json.decode(responce.body);
      return postJson.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Erorr fetching comments');
    }
  }

  Future<void> postCommentToPost(Comment comment) async {
    final responce = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'postId': comment.postId,
          'name': comment.user,
          'email': '',
          'body': comment.body,
        }),
    );

    print('POST: ${json.decode(responce.body)}');

    if (responce.statusCode != 201) {
      throw Exception('Erorr sending comment');
    }
  }
}