import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../screens/chat_screen.dart';


class PostItem extends StatelessWidget {

  final Post post;

  const PostItem(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: post.postid);

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(post.imagrUrl),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            const SizedBox(height: 6),
            Text(post.username,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6),
            const SizedBox(height: 6),
            Text(post.description,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5),
          ],
        ),
      ),
    );
  }
}