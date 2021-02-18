import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Icon icon;
  final String data;

  const CustomTile({Key key, this.icon, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, Text(" " + data)],
      ),
    );
  }
}
