
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/bloC/auth_cubit.dart';
import 'package:social_media_app/screens/post_screen.dart';


class SignUpScreen extends StatefulWidget {
  static const String route="sign_up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 String _email="";
 String _password="";
 String _username="";
bool input=false;
 final  _formkey=GlobalKey<FormState>();
late final FocusNode usernameFocusnode;
 late final FocusNode passwordFocusnode;
 @override
  void initState() {
    usernameFocusnode=FocusNode();
    passwordFocusnode=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    usernameFocusnode.dispose();
    passwordFocusnode.dispose();
    super.dispose();
  }
 void submit(){
   FocusScope.of(context).unfocus();
   if(!_formkey.currentState!.validate()) {
     return;
   }
   _formkey.currentState?.save();
   context.read<AuthCubit>().signUpWithEmail(email: _email,  username:_username,password: _password);

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      extendBodyBehindAppBar: true,
     body: SafeArea(


       child: Form(
         key: _formkey,

         child: BlocConsumer<AuthCubit,AuthState>(
           listener:(prevstate,currstate){
        if(currstate is AuthSignedUp){
         Navigator.of(context).pushReplacementNamed(PostsScreen.routeName);
          }
      if(currstate is AuthError){
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(currstate.message),duration: Duration(seconds: 10),));
     }
           },
           builder:(context,state){
             if(state is AuthLoading){
               return Center(child:CircularProgressIndicator());
             }
             else{
               return ListView(
                 padding: EdgeInsets.all(20),
                 physics: ClampingScrollPhysics(),
                 children:[
                   const SizedBox(
                     height: 15,
                   ),


                   TextFormField(
                     keyboardType:  TextInputType.emailAddress,
                     textInputAction: TextInputAction.none,
                     onSaved: (value){
                       _email=value!.trim();
                     },
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return " Please emailAddress";
                       }
                       else {
                         return null;
                       }
                     },
                     onFieldSubmitted: (_)=> FocusScope.of(context).requestFocus(usernameFocusnode),
                     style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                     decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                         filled: true,
                         fillColor: Colors.white,
                         hintText: "Enter Email Address"

                     ),
                   ),
                   const SizedBox(
                     height: 15,
                   ),
                   TextFormField(
                     focusNode: usernameFocusnode,
                     textInputAction: TextInputAction.next,
                     onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusnode),

                     onSaved: (value){
                       _username=value!.trim();
                     },
                     style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                     decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                         filled: true,
                         fillColor: Colors.white,
                         hintText: "Enter username"

                     ),

                   ),
                   const SizedBox(


                     height: 15,
                   ),
                   TextFormField(
                     focusNode: passwordFocusnode,
                     obscureText: true,

                     onSaved: (value){
                       _password=value!.trim();
                     },
                     onFieldSubmitted: (_) => submit(),
                     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                     decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,

                         border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),

                         labelText: "Confirm Password"

                     ),
                   ),
                   ElevatedButton(
                       onPressed: (){
                         submit();
                         }, child: const Text("Sign Up")),

                 ],
               );
             }
           },

         ),

       ),


     ),

    );
  }
}
