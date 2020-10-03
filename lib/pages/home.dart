import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/pages/connect.dart';
import 'package:minigamesparty/pages/create.dart';
import 'package:minigamesparty/pages/welcome.dart';
import 'package:minigamesparty/services/localization.dart';
import 'package:minigamesparty/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  final List<Widget> _tabs = [WelcomePage(), CreatePage(), ConnectPage()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: TabBarView(
            children: _tabs,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: ConvexAppBar(
            curve: Curves.ease,
            items: [
              TabItem(icon: MdiIcons.homeOutline, title: "Home"),
              TabItem(
                  icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF5722),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 40),
              )),
              TabItem(icon: MdiIcons.menu, title: "Join")
            ],
            style: TabStyle.fixedCircle,
            onTabNotify: (i) {
              var intercept = i == 1;
              if (intercept) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
              }
              return !intercept;
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
