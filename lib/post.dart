import 'package:flutter/material.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  final String url = "https://via.placeholder.com/600/f66b97";

  Post(
      {@required this.userId,
      @required this.id,
      @required this.title,
      @required this.body});
}
