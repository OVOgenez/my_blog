class Comment {
  int id;
  int postId;
  String user;
  String body;

  Comment({this.id, this.postId, this.user, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      user: json['name'],
      body: json['body'],
    );
  }
}