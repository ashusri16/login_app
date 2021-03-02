import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/providers/image_provider.dart';
import 'package:loginapp/utils/colors.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatelessWidget {
  @required
  final AsyncSnapshot snapshot;

  const ProfilePicture({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageStateProvider>(
      builder: (context, imageState, child) {
        print("inside pic builder");
        print(imageState.currentStatus);
        if (snapshot.data['profileUrl'] == 'notAdded') {
          return GestureDetector(
            onTap: () async {
              PickedFile photo =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (photo != null)
                await Users.addProfilePicture(
                  context,
                  photo,
                );
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/homePage', ModalRoute.withName('/dashBoard'));
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 70,
              child: Icon(
                Icons.add_a_photo,
                color: MyColors.primaryColor,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onLongPress: () async {
              PickedFile photo =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (photo != null)
                await Users.addProfilePicture(
                  context,
                  photo,
                );
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/homePage', ModalRoute.withName('/dashBoard'));
            },
            child: Container(
              height: 140,
              width: 140,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                snapshot.data['profileUrl'],
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircleAvatar(
                      radius: 70,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
