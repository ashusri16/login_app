import 'package:flutter/material.dart';
import 'package:loginapp/pages/dash_board/drawer.dart';
import 'package:loginapp/pages/dash_board/page_views/profile.dart';
import 'package:loginapp/utils/colors.dart';

class DashBoard extends StatefulWidget {
  final AsyncSnapshot snapshot;
  DashBoard({Key key, this.snapshot}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int currentIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "DashBoard",
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: DBDrawer(
          pageController: pageController,
        ),
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: [
            Profile(
              snapshot: widget.snapshot,
            ),
            Container(
              color: MyColors.primaryColor.withOpacity(0.2),
            ),
            Container(
              color: MyColors.primaryColor.withOpacity(0.4),
            ),
            Container(
              color: MyColors.primaryColor.withOpacity(0.6),
            ),
            Container(
              color: MyColors.primaryColor.withOpacity(0.8),
            ),
          ],
          physics: NeverScrollableScrollPhysics(),
          allowImplicitScrolling: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (pageNo) {
            pageController.jumpToPage(pageNo);
            setState(() {
              currentIndex = pageNo;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "profile",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.label_important_outline), label: "page"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_florist_rounded), label: "items"),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Files"),
          ],
          unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
          selectedIconTheme: IconThemeData(color: MyColors.primaryColor),
          selectedItemColor: Colors.grey[700],
          selectedFontSize: 12,
        ));
  }
}
