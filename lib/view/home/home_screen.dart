import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: (){

            },
            child: Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("Full SEO Course and Tutorial in Hindi"),
            subtitle: Text("shahab mustafa 8 months ago"),
            onTap: (){

            },
          ),
        ],
      )
    );
  }
}
