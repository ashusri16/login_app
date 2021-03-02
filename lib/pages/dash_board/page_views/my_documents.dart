import 'package:flutter/material.dart';

class MyDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Documents",
          style: TextStyle(color: Colors.grey[700]),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("List of your Documents"),
      ),
    );
  }
}
