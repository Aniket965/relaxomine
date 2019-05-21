import 'package:flutter/material.dart';
import 'VolumeSlider.dart';
import 'SystemVolume.dart';
import 'SoundPlaylist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double currentvol = 0.75;
  bool isPlayed = false;


  @override
  void initState() {
    super.initState();
    startPlayer.stream$.listen((val) async {
      if (val == 1) {
        setState(() {
          isPlayed = true;
        });
      }
    });
    //  if (mMusicUrl.startsWith('assets')) mMusicUrl = mMusicUrl.replaceFirst("assets/", "asset:///flutter_assets/assets/");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: new BottomAppBar(
              color: Colors.black,
              child: isPlayed
                  ? new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 36),
                            child: FloatingActionButton(
                              elevation: 6,
                              highlightElevation: 7,
                              onPressed: () => stopPlayer.stop(),
                              child: Image.asset(
                                "assets/images/stop.png",
                                height: 24,
                                alignment: Alignment.centerLeft,
                              ),
                              foregroundColor: Color(0xffFF2576),
                              backgroundColor: Color(0xffFF2576),
                            ))
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(36, 0, 12, 36),
                      child: Text(
                        "To play sounds tap on any sound and slide to adjust volume of individual sounds",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w900,
                            fontSize: 10),
                      ))),
          body: SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.1,
                      0.4,
                    ],
                    colors: [
                      Color(0xff241930),
                      Colors.black,
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(36, 48, 0, 24),
                    child: Text(
                      "RELAXAMINE",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                  ),
                  SoundPlaylist(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
