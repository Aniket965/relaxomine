import 'package:flutter/material.dart';

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
                      child: GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) {
                            print("Drag Left - AddValue");
                            print(details);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 120),
                            decoration: new BoxDecoration(
                                color: Color(0xffFF2576),
                                borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(50.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(255, 37, 118, .65),
                                      offset: Offset(0, 12),
                                      blurRadius: 19,
                                      spreadRadius: -4)
                                ]),
                            height: 56,
                            width: 200,
                            child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(children: [
                                  Image.asset(
                                    "assets/images/playbutton.png",
                                    height: 24,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                      child: Text(
                                        "12:01:24",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.3),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ))
                                ])),
                          )),
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
