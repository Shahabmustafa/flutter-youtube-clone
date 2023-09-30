import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/api/apis.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  File? _video;
  ImagePicker imagePicker = ImagePicker();
  VideoPlayerController? videoController;
  final contentController = TextEditingController();
  final decriptionController = TextEditingController();

  _videoPickerCamer()async{
    final video = await imagePicker.pickVideo(source: ImageSource.camera);
    if(video != null){
      _video = File(video.path);
      videoController = VideoPlayerController.file(_video!)..initialize().then((value){
        setState(() {});
        videoController!.play();
        videoController!.setLooping(true);
      });
    }
  }
  _videoPickerGallery()async{
    final video = await imagePicker.pickVideo(source: ImageSource.gallery);
    if(video != null){
      _video = File(video.path);
      videoController = VideoPlayerController.file(_video!)..initialize().then((value){
        setState(() {});
        videoController!.play();
        videoController!.setLooping(true);
      });
    }
  }
  Future uploadVideo()async{
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('productImage').child('');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File((_video!.path)));
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    FirebaseFirestore.instance.collection('post').doc(APIs.user.uid).collection("videoUpload").add({
      "uid" : APIs.user.uid,
      "videoUrl" : newUrl,
      "userName" : APIs.user.displayName,
      "profileUrl" : APIs.user.photoURL,
      "userEmail" : APIs.user.email,
      "videoContent" : contentController.text,
      "decriptionContant" : decriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           _video == null ? SizedBox(
             child: Text("Please Pick Your Video"),
             height: 200,
           ) : ConstrainedBox(
             constraints: BoxConstraints(maxHeight: 400,maxWidth: 200),
             child: AspectRatio(
               aspectRatio: videoController!.value.aspectRatio,
               child: VideoPlayer(videoController!),
             ),
           ),
           SizedBox(
             height: 30,
           ),
           TextFormField(
             controller: contentController,
             decoration: InputDecoration(
               hintText: "Video Content",
               border: OutlineInputBorder(),
             ),
           ),
           SizedBox(
             height: 10,
           ),
           TextFormField(
             controller: decriptionController,
             decoration: InputDecoration(
               hintText: "Video Description",
               border: OutlineInputBorder(),
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ElevatedButton(
                 child: Text('Edit Videos'),
                 onPressed: () {
                   showModalBottomSheet(
                     context: context,
                     builder: (context) {
                       return Wrap(
                         children: [
                           ListTile(
                             leading: Icon(Icons.camera_alt),
                             title: Text('upload to Camera'),
                             onTap: ()async{
                               _videoPickerGallery();
                             },
                           ),
                           ListTile(
                               leading: Icon(Icons.photo),
                               title: Text('upload to Gallery'),
                               onTap: ()async{
                                 _videoPickerCamer();
                               }
                           ),
                         ],
                       );
                     },
                   );
                 },
               ),
               ElevatedButton(
                 child: Text('Share Post'),
                 onPressed: uploadVideo,
               ),
             ],
           ),
         ],
       ),
     ),
   );
  }
}
