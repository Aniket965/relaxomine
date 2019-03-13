import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class SoundPlaylist extends StatefulWidget {
  @override
  _SoundPlaylistState createState() => _SoundPlaylistState();
}

class _SoundPlaylistState extends State<SoundPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(56, 0, 0, 0),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24), topLeft: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PlayerlistItem(
              name: "Rain",
              soundDetail: "MILD SOUND",
            ),
        
          ],
        ),
      ),
    );
  }
}

class PlayerlistItem extends StatefulWidget {
  String name;
  String soundDetail;
  PlayerlistItem({this.name, this.soundDetail});
    @override
  _PlaylistItemState createState() => _PlaylistItemState(name: this.name,soundDetail: this.soundDetail);
}

  enum PlayerState  {stopped,playing,paused} 
class _PlaylistItemState extends State<PlayerlistItem> {
  String name;
  String soundDetail;
  Duration duration;
  Duration position;
  AudioPlayer audioPlayer;
  String mMusicUrl = "asset://flutter_assets/assets/sound/brownnoise.wav";
  PlayerState playerState = PlayerState.stopped;
  _PlaylistItemState({this.name, this.soundDetail});


  Future playLocal(localFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = new File("${dir.path}/$localFileName");
    if (!(await file.exists())) {
      final soundData = await rootBundle.load("assets/$localFileName");
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }
    await audioPlayer.play(file.path, isLocal: true);
  }

  @override
  void initState() {
     super.initState();
     audioPlayer = new AudioPlayer();
    //  if (mMusicUrl.startsWith('assets')) mMusicUrl = mMusicUrl.replaceFirst("assets/", "asset:///flutter_assets/assets/");

  }

  Future playSound() async {
  await audioPlayer.play(mMusicUrl,isLocal: true);
}
  @override
  Widget build(BuildContext context) {
    double barlength = MediaQuery.of(context).size.width;
    return Container(
      width: barlength - 112,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(197, 197, 197, 0.2)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Text(
              this.name,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 12),
            child: Text(
              this.soundDetail,
              style: TextStyle(
                  color: Color.fromRGBO(197, 197, 197, 1),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          RaisedButton(child: Text("play"), onPressed: () => playLocal("brownnoise.wav"),)
        ],
      ),
    );
  }
}
