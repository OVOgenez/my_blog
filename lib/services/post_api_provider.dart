import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_blog/models/post.dart';

class PostProvider {
  Future<List<Post>> getAllPosts() async {
    final responce = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    print('GET: ${json.decode(responce.body)}');

    if (responce.statusCode == 200) {
      final List<dynamic> postJson = json.decode(responce.body);
      return postJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Erorr fetching posts');
    }
  }

  Future<Post> getPost(int id) async {
    final responce = await http.get(Uri.parse('https://my-json-server.typicode.com/OVOgenez/db/posts/' + '$id'));

    print('POST: ${json.decode(responce.body)}');

    if (responce.statusCode == 200) {
      final dynamic postJson = json.decode(responce.body);
      return Post.fromJson(postJson);
    } else {
      throw Exception('Erorr fetching post');
    }
  }
}