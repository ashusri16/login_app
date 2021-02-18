import 'package:flutter/material.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/local_widgets/custom_tile.dart';
import 'package:image_picker/image_picker.dart';

class DashBoard extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const DashBoard({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Users.logOut(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150,
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
                  height: MediaQuery.of(context).size.height - 240,
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
                              CustomTile(
                                  icon: Icon(
                                    Icons.date_range,
                                    size: 30,
                                  ),
                                  data: snapshot.data['birthDate']),
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
              child: snapshot.data['profileUrl'] == 'notAdded'
                  ? GestureDetector(
                      onTap: () async {
                        PickedFile photo = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (photo != null)
                          Users.addProfilePicture(context, photo);
                      },
                      child: CircleAvatar(
                        radius: 70,
                        child: Icon(Icons.add_a_photo),
                      ),
                    )
                  : Container(
                      height: 140,
                      width: 140,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        snapshot.data['profileUrl'],
                        fit: BoxFit.fill,
                      ),
                    ),
              top: 90,
              right: MediaQuery.of(context).size.width / 2 - 70,
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
