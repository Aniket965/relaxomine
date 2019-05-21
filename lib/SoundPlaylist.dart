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
      margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24), topLeft: Radius.circular(24)),
          ),
          height: MediaQuery.of(context).size.height / 1.75,
          child: new ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              PlayerlistItem(
                  r: 147,
                  g: 45,
                  b: 31,
                  name: "Brown Noise",
                  soundDetail: "CALM SOUND",
                  musicUri: "brownnoise.wav"),
              PlayerlistItem(
                  r: 63,
                  g: 64,
                  b: 245,
                  name: "Stream",
                  soundDetail: "RUNNING WATER",
                  musicUri: "stream.mp4"),
              PlayerlistItem(
                  r: 6,
                  g: 157,
                  b: 116,
                  name: "Cicadas",
                  soundDetail: "MILD SOUND",
                  musicUri: "cicadas.mp4"),
              PlayerlistItem(
                  r: 255,
                  g: 134,
                  b: 57,
                  name: "Metal",
                  soundDetail: "CHIME SOUND",
                  musicUri: "chimesmetal.mp4"),
              PlayerlistItem(
                  r: 243,
                  g: 70,
                  b: 70,
                  name: "BIRDS",
                  soundDetail: "MORING SOUNDS",
                  musicUri: "birds.ogg"),
            ],
          )),
    );
  }
}

class PlayerlistItem extends StatefulWidget {
  String name;
  String soundDetail;
  String musicUri;
  int r, g, b;
  PlayerlistItem(
      {this.name, this.soundDetail, this.musicUri, this.r, this.g, this.b});
  @override
  _PlaylistItemState createState() => _PlaylistItemState(
      name: this.name,
      soundDetail: this.soundDetail,
      musicUri: this.musicUri,
      r: this.r,
      b: this.b,
      g: this.g);
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
  bool _isSelected = false;
  int r;
  int g;
  int b;
  double percentage = 0.5;
  double initial = 0;
  MaterialAccentColor selectColor = Colors.lightBlueAccent;
  _PlaylistItemState({
    this.name,
    this.soundDetail,
    this.musicUri,
    this.r,
    this.g,
    this.b,
  });

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
      audioPlayer.setVolume(this._discreteValue * val);
    });

    stopPlayer.stream$.listen((val) async {
      if (val == 1) {
        setState(() {
          playerState = PlayerState.stopped;
          _isSelected = false;
        });
        await audioPlayer.stop();
      }
    });
    //  if (mMusicUrl.startsWith('assets')) mMusicUrl = mMusicUrl.replaceFirst("assets/", "asset:///flutter_assets/assets/");
  }

  Future playSound() async {
    await audioPlayer.play(musicUri, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    double barlength = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (playerState != PlayerState.playing) {
              setState(() {
                _isSelected = true;
              });
              playLocal(this.musicUri);
            } else {
              setState(() {
                playerState = PlayerState.stopped;
                _isSelected = false;
              });
              await audioPlayer.stop();
            }
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(24, 12, 0, 0),
              width: barlength - 112,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(197, 197, 197, 0.2)))),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/sound.png",
                    color: Colors.grey,
                    height: 30,
                    alignment: Alignment.centerLeft,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
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
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                        child: Text(
                          this.soundDetail,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 197, 197, 1),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        _isSelected
            ? GestureDetector(
                onPanStart: (DragStartDetails details) {
                  initial = details.globalPosition.dx;
                },
                onPanUpdate: (DragUpdateDetails details) {
                  double distance = details.globalPosition.dx - initial;
                  double percentageAddition = distance / barlength;
                  setState(() {
                    percentage =
                        ((percentage + percentageAddition) / 2).clamp(0.0, 1.0);
                  });

                  audioPlayer.setVolume(
                      ((percentage + percentageAddition) / 2).clamp(0.0, 1.0) *
                          this.sysvoll);
                },
                onPanEnd: (DragEndDetails details) {
                  initial = 0.0;
                },
                onTap: () async {
                  setState(() {
                    _isSelected = false;
                    playerState = PlayerState.stopped;
                  });
                  await audioPlayer.stop();
                },
                child: Container(
                  height: 67,
                  width: (barlength / 2) * percentage + (barlength / 2),
                  decoration: new BoxDecoration(
                      color: Color.fromRGBO(this.r, this.g, this.b, 1),
                      borderRadius: new BorderRadius.only(
                        topRight: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(this.r, this.g, this.b, .65),
                            offset: Offset(0, 12),
                            blurRadius: 19,
                            spreadRadius: -4)
                      ]),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(24, 12, 0, 0),
                      width: barlength - 112,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(197, 197, 197, 0.2)))),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/sound.png",
                            color: Colors.white,
                            height: 30,
                            alignment: Alignment.centerLeft,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  this.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                                child: Text(
                                  this.soundDetail,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              )
            : Container()
      ],
    );
  }
}
