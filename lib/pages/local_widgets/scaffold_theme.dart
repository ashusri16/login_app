import 'package:flutter/material.dart';
import 'package:loginapp/utils/colors.dart';

class ScaffoldTheme extends StatelessWidget {
  final String pageTitle;
  final List<Widget> children;
  final String buttonTitle;
  final Function onPressed;
  final Widget bottomLink;
  final bool isLoading;

  const ScaffoldTheme(
      {Key key,
      this.pageTitle,
      this.buttonTitle,
      this.onPressed,
      this.children,
      this.bottomLink,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 80),
                    alignment: Alignment.center,
                    constraints: BoxConstraints.expand(),
                    color: MyColors.primaryColor,
                    child: Text(
                      pageTitle,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(28),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 80),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: MyColors.greyDark.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10)
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(31)),
                          color: MyColors.primaryColor,
                          child: isLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.grey[500],
                                )
                              : Text(
                                  buttonTitle,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                          onPressed: onPressed,
                        ),
                      ),
                    ),
                    bottom: 0,
                  )
                ],
              ),
            ),
            Positioned(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: bottomLink,
              ),
              bottom: 50,
            )
          ],
        ),
      ),
    );
    ;
  }
}
