import 'package:flutter/material.dart';

class BlogPost {
  //final String id;
  final String title;
  final String content;
  final String author;
  final DateTime timestamp;
  final String imageUrl; // Added imageUrl field for the picture

  BlogPost({
    //required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.timestamp,
    required this.imageUrl,
    required String id,
  });




}
