import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  File? _video;
  PlatformFile? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  VideoPlayerController _videoPlayerController = VideoPlayerController as VideoPlayerController;

  _videoPicker()async{
    final video = await imagePicker.pickVideo(source: ImageSource.camera);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((value){
      setState(() {

      });
      _videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       children: [
        pickedFile != null ?
           Expanded(
             child: Container(
               child: Image.file(File(pickedFile!.path!),
                 width: double.infinity,
                 height: 300,
               ),
             ),
           ) : Center(
          child: ElevatedButton(
            child: Text('Share Videos'),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('upload to Camera'),
                        onTap: ()async{},
                      ),
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text('upload to Gallery'),
                        onTap: ()async{
                          _videoPicker();
                        }
                      ),
                      ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                        onTap: (){

                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
       ],
     ),
   );
  }
}
