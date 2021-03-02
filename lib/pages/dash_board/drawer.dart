import 'package:flutter/material.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/dash_board/page_views/profile.dart';

class DBDrawer extends StatelessWidget {
  final PageController pageController;
  final AsyncSnapshot snapshot;

  const DBDrawer({Key key, this.pageController, this.snapshot})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextStyle buttonTextStyle = Theme.of(context).textTheme.bodyText1;
    final Divider divider = Divider(
      color: Colors.white,
      height: 20,
    );
    return Container(
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width * 2 / 3,
      padding: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          divider,
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "My Profile",
                  style: buttonTextStyle,
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pageController.jumpToPage(0);
            },
          ),
          divider,
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "About us",
                  style: buttonTextStyle,
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/aboutUs');
            },
          ),
          divider,
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(
                    Icons.privacy_tip,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Privacy Policies",
                  style: buttonTextStyle,
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/policy');
            },
          ),
          divider,
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Logout",
                  style: buttonTextStyle,
                ),
              ],
            ),
            onPressed: () {
              Users.logOut(context);
            },
          ),
          divider,
        ],
      ),
    );
  }
}
