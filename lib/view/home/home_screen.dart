import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/api/apis.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController? videoController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('post').doc(APIs.user.uid).collection("videoUpload").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:(context,index){
                  var data = snapshot.data!.docs[index];
                  videoController = VideoPlayerController.networkUrl(Uri.parse(data["videoUrl"]))..initialize().then((value){
                    setState(() {});
                    videoController!.play();
                    videoController!.setLooping(true);
                  });
                  return InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: size.height * 0.56,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: videoController!.value.aspectRatio,
                            child: VideoPlayer(videoController!),
                          ),
                          // Container(
                          //   height: size.height * 0.25,
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey,
                          //   ),
                          //   // child: ,
                          // ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data["profileUrl"]),
                            ),
                            title: Text(data["videoContent"]),
                            subtitle: Text(data["userName"]),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
