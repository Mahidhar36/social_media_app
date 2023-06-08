
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chatmodel;
  final String currentUserId;
  const ChatBubble(this.chatmodel,this.currentUserId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatmodel;
    return Container(

      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
          crossAxisAlignment:  chatmodel.userid==currentUserId ? CrossAxisAlignment.end: CrossAxisAlignment.start,
          children:[
            Text(chatmodel.username,style: const TextStyle(color: Colors.white)),
            Text(chatmodel.message,style: const TextStyle(color: Colors.white),),]),
    );
  }
}
