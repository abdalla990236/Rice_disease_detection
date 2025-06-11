import 'dart:io';

class Post {
  String question;
  File? image;
  int upvotes;
  int downvotes;

  Post({
    required this.question,
    this.image,
    this.upvotes = 0,
    this.downvotes = 0,
  });
}

class PostStore {
  static List<Post> posts = [];
}
