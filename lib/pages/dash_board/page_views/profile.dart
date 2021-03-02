import 'package:flutter/material.dart';
import 'package:loginapp/pages/local_widgets/custom_tile.dart';
import 'package:loginapp/pages/local_widgets/profile_pic_widget.dart';
import 'package:loginapp/providers/image_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const Profile({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        snapshot.data['displayName'].toString().toUpperCase(),
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
                              data: snapshot.data['phNumber'],
                            ),
                            CustomTile(
                                icon: Icon(
                                  Icons.mail,
                                  size: 30,
                                ),
                                data: snapshot.data['email']),
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
            child: ChangeNotifierProvider(
              create: (_) => ImageStateProvider(),
              child: ProfilePicture(
                snapshot: snapshot,
              ),
            ),
            top: 70,
            right: MediaQuery.of(context).size.width / 2 - 70,
          )
        ],
      ),
    );
  }
}
