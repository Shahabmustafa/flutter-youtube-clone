import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_clone/api/apis.dart';
import 'package:youtube_clone/helper/dialogs.dart';
import 'package:youtube_clone/model/user_model.dart';

import '../../api/google_auth.dart';
import '../navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/youtube.png",height: 50,width: 50,),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text("YOUTUBE",style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2,
                ),)
              ],
            ),
            InkWell(
              onTap: (){
                Dialogs.showProgressBar(context);
                try{
                  signInWithGoogle().then((value){
                    APIs.createUser().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                    });
                  }).onError((error, stackTrace){

                  });
                }catch(e){

                }
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/search.png",height: 30,width: 30,),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Text("Sign in Google",style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
