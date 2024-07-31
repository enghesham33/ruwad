import 'dart:async';
import 'package:flutter/material.dart';



class AnimatedHeader extends StatefulWidget //with PreferredSizeWidget
{
    final String title;
    final Color color;
    final Size size;
     AnimatedHeader({Key? key, required this.title, required this.color, required this.size}) : super(key: key);


  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader> {

  late Timer _timer;
  late double height= widget.size.height*0.15;
  double opacity=0.1;

  _AnimatedHeaderState() {
     //height=100;
    _timer = Timer(const Duration(milliseconds: 100), () {
      height= widget.size.height*0.70;
      opacity=0.8;
      setState(() {
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer
        (
          duration: const Duration(seconds: 1),
          width: widget.size.width,
          height: height,
          decoration:  BoxDecoration
          (
            color: widget.color.withOpacity(opacity),
            borderRadius:const BorderRadius.only
            (
              bottomRight: Radius.circular(100),
             // bottomLeft: Radius.circular(100)
            )
          ),
           child: Padding(
             padding: const EdgeInsets.all(50.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(widget.title),

               ],
             ),
           ),
          
        );
  }
}