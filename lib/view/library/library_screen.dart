import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  
  late YoutubePlayerController controller;
  final VideoURL = "https://www.youtube.com/watch?v=-UJCMfuFtSQ";
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(VideoURL);
    controller = YoutubePlayerController(
        initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              child: Text("Recent",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.start,),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.5,
                        color: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              Container(
                                height: size.height * 0.13,
                                width: double.infinity,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image.asset("assets/images/download.jpeg",fit: BoxFit.cover,),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        height: 22,
                                        width: 35,
                                        color: Colors.black,
                                        child: Center(child: Text("1:20",style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("The World In HDR in 4K",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Shahab Mustafa"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History"),
            ),
            ListTile(
              leading: Icon(Icons.video_library_sharp),
              title: Text("My Video"),
            ),
            ListTile(
              leading: Icon(Icons.sell_sharp),
              title: Text("Purchases"),
            ),
            ListTile(
              leading: Icon(Icons.access_time_filled),
              title: Text("Watch later"),
            ),
            // YoutubePlayer(
            //   controller: controller,
            //   showVideoProgressIndicator: true,
            //   progressColors: ProgressBarColors(
            //     playedColor: Colors.red,
            //     handleColor: Colors.red
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}
