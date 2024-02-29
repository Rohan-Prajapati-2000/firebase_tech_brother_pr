import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/login_screen.dart';
import 'package:firebase_practice/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;



    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        title: Center(child: Text("Home")),
        backgroundColor: Colors.yellow.shade600,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          },
              icon: Icon(Icons.logout)),
          SizedBox(width: 15)
        ],
      ),
      body: Center(child: Text("This is home screen")),
    );
  }

}