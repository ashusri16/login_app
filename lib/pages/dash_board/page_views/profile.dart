import 'package:flutter/material.dart';
import 'package:loginapp/pages/local_widgets/custom_tile.dart';
import 'package:loginapp/utils/colors.dart';

class Profile extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const Profile({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 130,
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  height: MediaQuery.of(context).size.height - 218,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100, bottom: 30),
                        child: Text(
                          "My Name",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTile(
                                icon: Icon(
                                  Icons.phone,
                                  size: 30,
                                ),
                                data: "+91-0123456789",
                              ),
                              CustomTile(
                                  icon: Icon(
                                    Icons.mail,
                                    size: 30,
                                  ),
                                  data: "abc@xyz.com"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              child: Container(
                height: 140,
                width: 140,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              ),
              top: 70,
              right: MediaQuery.of(context).size.width / 2 - 70,
            )
          ],
        ),
      ),
    );
  }
}
