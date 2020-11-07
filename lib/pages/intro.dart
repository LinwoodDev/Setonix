import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WelcomePage());
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static final List _items = [
    {
      "header": "Welcome!",
      "description": "Swipe to get an introduction. Click on skip to skip it.",
      "image": MdiIcons.robot
    },
    {
      "header": "Play on everywhere device",
      "description": "Play games on mobile and desktop!",
      "image": MdiIcons.plusCircleMultipleOutline
    },
    {
      "header": "With and without internet",
      "description": "Play together with bluetooth or with internet!",
      "image": MdiIcons.lockOutline
    }
  ];
  final _pageViewController = PageController();
  double _currentPage = 0;
  List<Widget> indicator() => List<Widget>.generate(
      _items.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            child: InkWell(
              onTap: () => _setPage(index),
            ),
            decoration: BoxDecoration(
                color: _currentPage.round() == index
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));
  void _setPage(int index) {
    _pageViewController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageViewController,
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              _pageViewController.addListener(() {
                setState(() {
                  _currentPage = _pageViewController.page;
                });
              });
              var item = _items[index];
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Icon(
                        item['image'],
                        size: 150,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(children: <Widget>[
                              Text(item['header'],
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0XFF3F3D56),
                                      height: 2.0)),
                              Text(
                                item['description'],
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1.2,
                                    fontSize: 16.0,
                                    height: 1.3),
                                textAlign: TextAlign.center,
                              )
                            ]))),
                  ]));
            },
          ),
          // Align(
          //     alignment: Alignment.bottomLeft,
          //     child: MouseRegion(
          //         cursor: SystemMouseCursors.click,
          //         child: GestureDetector(
          //             onTap: () {
          //               launch("https://linwood.tk", forceWebView: true);
          //             },
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Image.asset("assets/icon.png", height: 50),
          //             )))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 70.0),
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicator(),
                ),
              )
              //  ),
              ),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                  (_currentPage <= _items.length - 1.5)
                      ? FlatButton(
                          onPressed: () {
                            _setPage(5);
                          },
                          child: Text("SKIP"),
                        )
                      : RaisedButton(
                          onPressed: () {
                            var prefBox = Hive.box("pref");
                            prefBox.put("first", false);
                            Navigator.of(context).pop();
                          },
                          child: Text("START"),
                        ),
                ]),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 32),
              ))
          // )
        ],
      ),
    );
  }
}
