import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Icon icon;
  final String data;

  const CustomTile({Key key, this.icon, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[400], width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          Text("   " + data),
        ],
      ),
    );
  }
}
