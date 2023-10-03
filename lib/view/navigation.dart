import 'package:flutter/material.dart';
import 'package:youtube_clone/api/apis.dart';
import 'package:youtube_clone/view/add%20video/add_video_screen.dart';
import 'package:youtube_clone/view/home/home_screen.dart';
import 'package:youtube_clone/view/library/library_screen.dart';
import 'package:youtube_clone/view/short/short_screen.dart';
import 'package:youtube_clone/view/subscription/subscription_screen.dart';
import '../model/user_model.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);
  // final UserModel user;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  bool _issearching = true;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ShortPage(),
    AddVideoPage(),
    SubscriptionPage(),
    LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _issearching ? Row(
          children: [
            Image.asset("assets/images/youtube.png",height: 30,width: 30,),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text("Youtube",style: TextStyle(fontWeight: FontWeight.w900),)
          ],
        ) :
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
          ),
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          Icon(Icons.collections_bookmark_sharp,size: 25,),
          SizedBox(
            width: size.width * 0.035,
          ),
          Icon(Icons.notifications,size: 25,),
          SizedBox(
            width: size.width * 0.035,
          ),
          InkWell(
            onTap: (){
              setState(() {
                _issearching = !_issearching;
              });
            },
            child: Icon(
              _issearching ? Icons.search :
              Icons.close,
              size: 25,
            ),
          ),
          SizedBox(
            width: size.width * 0.035,
          ),
          InkWell(
            onTap: (){
              APIs.auth.signOut().then((value){});
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(APIs.user.photoURL.toString()),
            ),
          ),
          SizedBox(
            width: size.width * 0.035,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_stable_outlined),
                label: "Shorts",
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline,size: 35,),
              label: "",
                backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: "Subscription",
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_rounded),
                label: "Library",
                backgroundColor: Colors.white
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 25,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
          elevation: 1,
      ),
    );
  }
}
