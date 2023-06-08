import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/bloC/auth_cubit.dart';
import 'package:social_media_app/screens/chat_screen.dart';
import 'package:social_media_app/screens/create_post_screen.dart';
import 'package:social_media_app/screens/post_screen.dart';
import 'package:social_media_app/screens/sign_in_screeen.dart';
import 'package:social_media_app/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
Widget buildhomescreen(){

  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
         builder:(context,snapshot){
           if(snapshot.hasData){
              return const PostsScreen();
           }
           else{
             return const SignInScreen();
           }
  }
  );
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context)=> AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),

        home:  buildhomescreen(),
        routes: {
          SignUpScreen.route:(context)=> const SignUpScreen(),
          SignInScreen.route: (context)=> const SignInScreen(),
         PostsScreen.routeName:(context) => const PostsScreen(),
          CreatePostScreen.routeName:(context)=> const CreatePostScreen(),
          ChatScreen.routeName:(context)=> const ChatScreen()
        },
      ),
    );
  }
}
