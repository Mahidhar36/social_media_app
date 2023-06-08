import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/bloC/auth_cubit.dart';
import 'package:social_media_app/screens/post_screen.dart';

import 'package:social_media_app/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String route="sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final textcontroller=TextEditingController();
  final textcontroller1=TextEditingController();
late final String _email;
  late  final String password;
   bool input=false;

 final  _formkey=GlobalKey<FormState>();

  late final FocusNode focusNode;
  @override
  void initState() {
    focusNode=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  void submit(){
    FocusScope.of(context).unfocus();
    if(!_formkey.currentState!.validate()){

      return ;
    }

    _formkey.currentState!.save();

    context.read<AuthCubit>().signInWithEmail(email: _email, password: password, );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(

        title: const Text("Log In" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.end,),

      ),
      body:   BlocConsumer<AuthCubit,AuthState>(
        listener:(prevstate,currstate){
          if(currstate is AuthError){
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(currstate.message),duration: const Duration(seconds: 2),));
          }
          if(currstate is AuthSignedIn){
            Navigator.of(context).pushNamed(PostsScreen.routeName);
          }
        },
        builder:(context,state){
    if(state is AuthLoading){
    return Center(child:CircularProgressIndicator());
    }
    else{
      return Form(
        key: _formkey,
        child: ListView(

          physics:  ClampingScrollPhysics(),

          children:  [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: TextFormField(

                controller:textcontroller ,
                textInputAction: TextInputAction.next,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return " Please enter emailAddress";
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (value){
                  _email=value!.trim();
                },
                onFieldSubmitted: (_)=> FocusScope.of(context).requestFocus(focusNode),
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(

                    border:const UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.green),

                    ),


                    labelText: "Enter your Name",

                    suffixIcon: IconButton(
                      onPressed: () {
                        textcontroller.clear();
                      }, icon:Icon(Icons.clear),

                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0,20, 20),
              child: TextFormField(

                focusNode: focusNode,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                onFieldSubmitted: (_){
                  submit();
                },

                style: const TextStyle(fontWeight: FontWeight.bold),
                validator: (value){
                  if(value==null || value.isEmpty){

                    return " Please Enter Password";
                  }
                  if(value.length<5){
                    return "Password Too Short";
                  }

                    return null;

                },
                onSaved: (value){
                  password=value!.trim();
                },
                controller:textcontroller1 ,
                decoration: InputDecoration(

                    border:const UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.red)
                    ),

                    labelText: "Enter your Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {

                        });
                      }, icon:Icon(Icons.clear),

                    )
                ),

              ),
            ),
            MaterialButton(
              onPressed: (){
              submit();

              },
              color: Colors.green,
              child:const Text("Next Page"),
            ),
            TextButton(
                onPressed: () {

                  Navigator.of(context).pushNamed(SignUpScreen.route);
            },
                child: const Text("Go to SignUpScreen")
            )
          ],
        ),
      );
    }
        },

      )

    );
  }
}
