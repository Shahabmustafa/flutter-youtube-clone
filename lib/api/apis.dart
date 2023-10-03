import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/model/user_model.dart';
import 'package:youtube_clone/view/login/login_screen.dart';

import '../view/navigation.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;

  static User get user => auth.currentUser!;

  static late UserModel me;


  static Future<void> createUser()async{
    final UserModel userModel = UserModel(
      email: user.email,
      photoUrl: user.photoURL,
      uid: user.uid,
      userName: user.displayName,
    );
    return await FirebaseFirestore.instance.collection("user").doc(user.uid).set(userModel.toJson());
  }

  login(BuildContext context){
    if(auth.currentUser != null){
      return Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      });
    }else{
      return Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }

}