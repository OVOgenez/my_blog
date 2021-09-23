class Post {
  int id;
  int user;
  String title;
  String body;

  Post({this.id, this.user, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}