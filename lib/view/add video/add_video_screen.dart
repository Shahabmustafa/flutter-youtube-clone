import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  String? _image;
  PlatformFile? pickedFile;

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
                        onTap: ()async{
                          final ImagePicker picker = ImagePicker();
                          final XFile? files = await picker.pickImage(source: ImageSource.camera);
                          if (files != null) {
                            setState(() {
                              _image = files.path;
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text('upload to Gallery'),
                        onTap: ()async{
                          final result = await FilePicker.platform.pickFiles();
                          setState(() {
                            pickedFile = result!.files.first;
                          });
                        },
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
