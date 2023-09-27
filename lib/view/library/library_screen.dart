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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red
              ),
            ),
          ],
        ),
      )
    );
  }
}
