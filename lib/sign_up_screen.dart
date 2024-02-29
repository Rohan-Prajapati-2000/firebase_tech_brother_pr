import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/login_screen.dart';
import 'package:firebase_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

 FirebaseAuth _auth = FirebaseAuth.instance;

 void signUp(){
   if(_formKey.currentState!.validate()){
     setState(() {
       loading = true;
     });
     _auth.createUserWithEmailAndPassword(
         email: emailController.text.toString(),
         password: passController.text.toString()).then((value){
       emailController.clear();
       passController.clear();
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
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
                      signUp();
                    },
                    child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text("Sign In", style: TextStyle(color: Colors.white),)),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}