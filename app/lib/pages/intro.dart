import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: WelcomePage());
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static final List _items = [
    {
      "header": "Welcome!",
      "description": "Swipe to get an introduction. Click on skip to skip it.",
      "image": PhosphorIcons.smileyWinkLight
    },
    {
      "header": "Play on everywhere device",
      "description": "Play games on mobile and desktop!",
      "image": PhosphorIcons.plusLight
    },
    {
      "header": "With and without internet",
      "description": "Play together with bluetooth or with internet!",
      "image": PhosphorIcons.lockLight
    }
  ];
  final _pageViewController = PageController();
  double? _currentPage = 0;

  List<Widget> indicator() => List<Widget>.generate(
      _items.length,
      (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            child: InkWell(
              onTap: () => _setPage(index),
            ),
            decoration: BoxDecoration(
                color:
                    _currentPage!.round() == index ? const Color(0XFF256075) : const Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  void _setPage(int index) {
    _pageViewController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(children: <Widget>[
                            Text(item['header'],
                                style: const TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0XFF3F3D56),
                                    height: 2.0)),
                            Text(
                              item['description'],
                              style:
                                  const TextStyle(color: Colors.grey, letterSpacing: 1.2, fontSize: 16.0, height: 1.3),
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
              margin: const EdgeInsets.only(top: 70.0),
              padding: const EdgeInsets.symmetric(vertical: 40.0),
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
                (_currentPage! <= _items.length - 1.5)
                    ? TextButton(
                        onPressed: () {
                          _setPage(5);
                        },
                        child: const Text("SKIP"),
                      )
                    : TextButton(
                        onPressed: () {
                          var prefBox = Hive.box("pref");
                          prefBox.put("first", false);
                          Navigator.of(context).pop();
                        },
                        child: const Text("START"),
                      ),
              ]),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 32),
            ))
        // )
      ],
    );
  }
}
