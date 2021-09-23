import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_blog/models/comment.dart';

class CommentProvider {
  Future<List<Comment>> getCommentsFromPost(int id) async {
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/${id}/comments'));

    if (responce.statusCode == 200) {
      final List<dynamic> postJson = json.decode(responce.body);
      return postJson.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Erorr fetching comments');
    }
  }
}