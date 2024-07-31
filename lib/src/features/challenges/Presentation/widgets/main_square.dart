
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainSquare extends StatelessWidget
{
   late double height;
   late double width;
   late Color mainColor ;
   int flex=0;
   List<Widget> childs=[];

  MainSquare(double height,double width,Color mainColor , {super.key,  required int flex, required List<Widget> childs} ){
    this.height=height;
    this.width=width;
    this.mainColor=mainColor;
    this.flex=flex;
    this.childs=childs;
  }
  @override
  Widget build(BuildContext context) {
    return Container
    (
      width: width,height: height,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration
      (
        
          color: mainColor.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0),
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          ),
          boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 1,
                  offset: const Offset(0, 1), // Shadow position
                ),
              ],
          
      ),
      
      child: (childs!=null && childs.length!=0)?
      Stack
      (
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: 
        this.childs,
      ):null,

    ); 
  }

}