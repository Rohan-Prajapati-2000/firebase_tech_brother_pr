import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/sign_up_screen.dart';
import 'package:firebase_practice/utils.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void logIn(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString()).then((value){
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          setState(() {
            loading = false;
          });
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 3, color: Colors.blue))),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Email";
                  }else{
                    return null;
                  }
                },
              ),


              SizedBox(height: 15),

              TextFormField(
                obscureText: true,
                controller: passController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 3, color: Colors.blue)
                  ),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Password";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 55,
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, elevation: 10),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        logIn();
                      }
                    },
                    child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white) : Text("Login", style: TextStyle(color: Colors.white),)),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                      child: Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
