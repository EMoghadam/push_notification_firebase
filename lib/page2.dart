import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueAccent,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          child:const Text(
          "Message Page",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        ),
      ),
    );
  }
}
