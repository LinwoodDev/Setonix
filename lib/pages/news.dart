import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<AtomFeed> getFeed() => http
      .get(Uri.parse("https://linwood.tk/blog/atom.xml"))
      .then((response) => AtomFeed.parse(utf8.decode(response.bodyBytes)));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AtomFeed>(
        future: getFeed(),
        builder: (BuildContext context, AsyncSnapshot<AtomFeed> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final feed = snapshot.data!;
                  return ListView.builder(
                    itemCount: feed.items!.length,
                    itemBuilder: (context, index) {
                      var current = feed.items![index];
                      return ListTile(
                        title: Text(current.title!),
                        subtitle: Text(current.summary!),
                        onTap: () async => await launch(current.id!),
                      );
                    },
                  );
                }
              }
              break;
            default:
          }
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        });
  }
}
