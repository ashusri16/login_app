import 'package:flutter/material.dart';
import 'package:loginapp/providers/size_provider.dart';
import 'package:loginapp/utils/colors.dart';
import 'package:provider/provider.dart';

class ListViewContent extends StatelessWidget {
  final String title;
  final String content;
  final Image image;
  final String index;

  const ListViewContent(
      {Key key, this.title, this.content, this.image, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(Provider.of<SizeProvider>(context));
    return SafeArea(
      child: Builder(
        builder: (newContext) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Provider.of<SizeProvider>(context, listen: false).incSize();
                  }),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    Provider.of<SizeProvider>(context, listen: false).decSize();
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Hero(
                    tag: "profileImg$index",
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: MyColors.primaryColor),
                      child: Container(
                        child: image,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 28,
                          fontFamily: 'Opensans'),
                    ),
                  ),
                  Consumer<SizeProvider>(
                    builder: (context, fontSize, child) =>
                        SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          content,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: fontSize.fontSize,
                              fontFamily: 'Opensans'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
