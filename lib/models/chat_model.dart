import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  final String userid;
  final String username;
  final Timestamp timestamp;
  final String message;
  ChatModel({required this.userid,required this.username,required this.message,required this.timestamp});


  ChatModel.fromSnapshot(QueryDocumentSnapshot doc):
        userid= doc["userId"],
  username= doc["username"] as String,
      message= doc["message"] as String,
      timestamp=  doc["timestamp"] as Timestamp;
}