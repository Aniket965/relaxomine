import 'package:flutter/material.dart';
import 'SystemVolume.dart';
class VolumeSlider extends StatelessWidget {
    double percentage;

    VolumeSlider({
      this.percentage,

    });


  @override
  Widget build(BuildContext context) {
  double totalwidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
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
      width: (totalwidth / 2) * percentage  + (totalwidth/2),
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
    );
  }
}
class GestureVolumeSlider extends StatefulWidget {
  GestureVolumeSlider();
  @override
  _GestureVolumeState createState() => _GestureVolumeState();
}

class _GestureVolumeState extends State<GestureVolumeSlider> {
  double percentage = 0.5;
  double initial = 0;
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
          percentage = (percentage + (percentageAddition)).clamp(0.0,1.0);
        });
        systemVolume.change((percentage + (percentageAddition)).clamp(0.0,1.0));
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
      },
      child: VolumeSlider(percentage: this.percentage,),
    );
  }
}
