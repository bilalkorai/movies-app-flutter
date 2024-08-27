import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class homescr extends StatefulWidget {
  @override
  State<homescr> createState() => _homescrState();
}

class _homescrState extends State<homescr> {
  List<String> _videoUrls = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final ListResult result = await FirebaseStorage.instance.ref('videos/').listAll();
    final List<String> urls = await Future.wait(result.items.map((Reference ref) async {
      return await ref.getDownloadURL();
    }).toList());

    setState(() {
      _videoUrls = urls;
      _isLoading = false;
    });
  }

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
                padding: const EdgeInsets.only(left: 0),
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
              padding: const EdgeInsets.only(right: 5),
              child: PopupMenuButton(
                constraints: BoxConstraints(
                    minHeight: 50, minWidth: 50, maxHeight: 70, maxWidth: 90),
                padding: EdgeInsets.all(9),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onSelected: (String value) {
                  menuselected(context, value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Text("Logout"),
                    )
                  ];
                },
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white,))
          : Padding(
        padding: const EdgeInsets.all(20),
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _videoUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ChewiePlayerWidget(url: _videoUrls[index]),
            );
          },
        ),
      ),
    );
  }
}

class ChewiePlayerWidget extends StatefulWidget {
  final String url;

  const ChewiePlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _ChewiePlayerWidgetState createState() => _ChewiePlayerWidgetState();
}

class _ChewiePlayerWidgetState extends State<ChewiePlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(

      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Check internet connection',style: TextStyle(color: Colors.white),));
          }
          return Chewie(controller: _chewieController!);
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        }
      },
    );
  }
}
