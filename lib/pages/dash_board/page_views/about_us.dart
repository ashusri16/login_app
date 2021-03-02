import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("This a dummy login app \n Tech Stack: FireBase, Flutter"),
      ),
    );
  }
}
