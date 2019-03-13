import 'package:flutter/material.dart';
import 'VolumeSlider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: new BottomAppBar(
            color: Colors.black,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
                    child: GestureVolumeSlider()),
              ],
            ),
          ),
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
                  Container(
                    // color: Colors.white,
                    height: 300,
                  ),
                  Column(
                    children: <Widget>[],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
