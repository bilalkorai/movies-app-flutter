import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class homescr extends StatefulWidget {
  @override
  State<homescr> createState() => _homescrState();
}

class _homescrState extends State<homescr> {
  final ref = FirebaseDatabase.instance.ref('videoss');

  void menuselected(BuildContext context, String value) {
    switch (value) {
      case 'logout':
        logout();
        break;
      case 'more':
        print("more");
    }
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 120,
                  width: 120,
                  child: Image.asset("assets/images/11.png"),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: PopupMenuButton(
                  constraints: BoxConstraints(
                      minHeight: 50,
                      minWidth: 50,
                      maxHeight: 70,
                      maxWidth: 90
                  ),
                  padding: EdgeInsets.all(9),
                  icon: Icon(Icons.menu, color: Colors.white,),
                  onSelected: (String value) {
                    menuselected(context, value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(value: 'logout', child: Text("Logout"),)
                    ];
                  }
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final videoUrl = snapshot.child('url').value.toString();
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: YoutubePlayerWidget(url: videoUrl),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YoutubePlayerWidget extends StatefulWidget {
  final String url;

  const YoutubePlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
