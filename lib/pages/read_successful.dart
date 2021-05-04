import 'package:flutter/material.dart';

class ReadSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Icon(Icons.check_box),
        ),
      ),
    );
  }
}
