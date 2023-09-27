import 'package:flutter/material.dart';
import 'package:youtube_clone/api/apis.dart';

import '../../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(UserModel().photoUrl);
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: InkWell(
        onTap: (){

        },
        child: Container(
          height: size.height * 0.35,
          child: Column(
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey
                ),
              ),
              ListTile(
                leading: CircleAvatar(),
                title: Text("Full SEO Course and Tutorial in Hindi"),
                subtitle: Text("shahab mustafa 8 months ago"),
              ),
            ],
          ),
        ),
      )
    );
  }
}
