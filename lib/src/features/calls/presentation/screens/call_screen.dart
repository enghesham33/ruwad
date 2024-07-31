import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rawdat_hufaz/src/shared/widgets/containers/custom_small_container.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  static String routeName = "Calls";

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("طلب تسميع"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              
            ]),
      ),
    );
  }
}
