import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bits/colors.dart';
import 'package:bits/pages/connect.dart';
import 'package:bits/pages/create/lobby.dart';
import 'package:bits/pages/news.dart';
import 'package:bits/pages/settings/home.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  final List<Widget> _tabs = [
    const NewsPage(),
    const CreateLobbyPage(),
    const ConnectPage()
  ];
  var prefBox = Hive.box("pref");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkFirstTime());
  }

  void checkFirstTime() {
    if (prefBox.get("first", defaultValue: true)) {
      Navigator.of(context).pushNamed("/intro");
    }
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
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(
                  icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                  tooltip: "Reset",
                  onPressed: () => prefBox.put("first", true)),
              IconButton(
                icon: const Icon(PhosphorIcons.gearLight),
                tooltip: "Settings",
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage())),
              )
            ],
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: _tabs,
          ),
          bottomNavigationBar: ConvexAppBar(
            curve: Curves.ease,
            backgroundColor: PaletteColors.primaryColor,
            items: [
              const TabItem(icon: PhosphorIcons.houseLight, title: "Home"),
              TabItem(
                  icon: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: PaletteColors.darkColor),
                child: const Icon(PhosphorIcons.plusLight,
                    color: Colors.white, size: 40),
              )),
              const TabItem(icon: PhosphorIcons.listLight, title: "Join")
            ],
            style: TabStyle.fixedCircle,
            onTabNotify: (i) {
              var intercept = i == 1;
              if (intercept) Navigator.pushNamed(context, "/create");
              return !intercept;
            },
          ),
        ));
  }
}
