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
                  Container(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 48, 0, 24),
                      child: GestureVolumeSlider()
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GestureVolumeSlider extends StatefulWidget {
  @override
  _GestureVolumeState createState() => _GestureVolumeState();
}

class _GestureVolumeState extends State<GestureVolumeSlider> {
  double percentage = 0.0;
  double initial = 0.0;

  @override
  Widget build(BuildContext context) {
      double totalwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        double distance = details.globalPosition.dx - initial;
        double percentageAddition = distance / totalwidth ;
        setState(() {
          percentage = (percentage + (percentageAddition/4)).clamp(0.0, 1.0);
        });
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
      },
      child: VolumeSlider(percentage: this.percentage,),
    );
  }
}
