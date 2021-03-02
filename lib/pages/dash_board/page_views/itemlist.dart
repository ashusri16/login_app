import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginapp/helpers/list_helper.dart';
import 'package:loginapp/pages/local_widgets/list_view.dart';
import 'package:loginapp/providers/size_provider.dart';
import 'package:loginapp/utils/colors.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  double size = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 25, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "inc",
              backgroundColor: MyColors.primaryColor,
              child: Icon(Icons.add),
              onPressed: () {
                Provider.of<SizeProvider>(context, listen: false).incSize();
              },
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: "dec",
              backgroundColor: MyColors.primaryColor,
              child: Icon(Icons.minimize_outlined),
              onPressed: () {
                Provider.of<SizeProvider>(context, listen: false).decSize();
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future: ListItems.list(),
          builder: (BuildContext context, AsyncSnapshot snaphot) {
            if (snaphot.connectionState == ConnectionState.done) {
              return Consumer<SizeProvider>(
                builder: (newContext, fontSize, child) => Container(
                  padding: EdgeInsets.all(24),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snaphot.data[index]['label'],
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: fontSize.fontSize),
                              ),
                              leading: Hero(
                                tag: "profileImg$index",
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.hardEdge,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.network(
                                    snaphot.data[index]['photoUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value:
                                          Provider.of<SizeProvider>(newContext),
                                      child: ListViewContent(
                                        title: snaphot.data[index]['label'],
                                        content: snaphot.data[index]['desc'],
                                        image: Image.network(
                                          snaphot.data[index]['photoUrl'],
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent imageChunks) {
                                            if (imageChunks == null)
                                              return child;

                                            return CircularProgressIndicator(
                                                backgroundColor: MyColors
                                                    .primaryColor
                                                    .withOpacity(0.8));
                                          },
                                        ),
                                        index: index.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: snaphot.data.length,
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[5000],
              ),
            );
          }),
    );
  }

  Future<void> _showDescription(
      BuildContext context, dynamic description, dynamic title) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: size,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Text(
                  description.toString(),
                  style: TextStyle(fontSize: size),
                ),
              ),
            ),
          );
        });
  }
}
