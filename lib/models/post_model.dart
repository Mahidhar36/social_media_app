import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userid;
  final String username;
  final Timestamp timestamp;
  final String imagrUrl;
  final String description;
  final String postid;
  Post(
      {required this.timestamp, required this.description, required this.imagrUrl, required this.userid, required this.username,required this.postid});










}