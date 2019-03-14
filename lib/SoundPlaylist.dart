import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'SystemVolume.dart';

class SoundPlaylist extends StatefulWidget {

  @override
  _SoundPlaylistState createState() => _SoundPlaylistState();
}

class _SoundPlaylistState extends State<SoundPlaylist> {
  _SoundPlaylistState();
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
                musicUri: "brownnoise.wav"),
            PlayerlistItem(
                name: "WATER",
                soundDetail: "MILD SOUND",
                musicUri: "water.wav"),
          ],
        ),
      ),
    );
  }
}

class PlayerlistItem extends StatefulWidget {
  String name;
  String soundDetail;
  String musicUri;
  PlayerlistItem({this.name, this.soundDetail, this.musicUri});
  @override
  _PlaylistItemState createState() => _PlaylistItemState(
      name: this.name, soundDetail: this.soundDetail, musicUri: this.musicUri) ;
}

enum PlayerState { stopped, playing, paused }

class _PlaylistItemState extends State<PlayerlistItem> {
  String name;
  String soundDetail;
  Duration duration;
  Duration position;
  AudioPlayer audioPlayer;
  String musicUri;
  PlayerState playerState = PlayerState.stopped;
  double _discreteValue = 0.5;
  double sysvoll = 0.75;
  MaterialAccentColor selectColor = Colors.lightBlueAccent;
  _PlaylistItemState({this.name, this.soundDetail, this.musicUri,});
 

  Future playLocal(localFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = new File("${dir.path}/$localFileName");
    if (!(await file.exists())) {
      final soundData = await rootBundle.load("assets/$localFileName");
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }
    setState(() {
      playerState = PlayerState.playing;
    });
    await audioPlayer.play(
      file.path,
      isLocal: true,
    );
    await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = new AudioPlayer();

    systemVolume.stream$.listen((val) {
      setState(() {
        sysvoll = val;
      });
      audioPlayer.setVolume( this._discreteValue * val);
    } );
    //  if (mMusicUrl.startsWith('assets')) mMusicUrl = mMusicUrl.replaceFirst("assets/", "asset:///flutter_assets/assets/");
  }

  Future playSound() async {
    await audioPlayer.play(musicUri, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    double barlength = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (playerState != PlayerState.playing) {
          setState(() {
            selectColor = Colors.blueAccent;
          });
          playLocal(this.musicUri);
        } else {
          setState(() {
            selectColor = Colors.lightBlueAccent;
            playerState = PlayerState.stopped;
          });
          await audioPlayer.stop();
        }
      },
      child: Container(
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
                    color: selectColor,
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
            Slider(
                value: this._discreteValue,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: (double value) {
                  audioPlayer.setVolume(value * this.sysvoll) ;
                  setState(() {
                    _discreteValue = value ;
                  });
                })
          ],
        ),
      ),
    );
  }
}
