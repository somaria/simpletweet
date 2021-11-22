import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String jsonFile = 'assets/tweet_examples/tweet_1_photo.json';

  /// Builds a TweetView from a JSON file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints.expand(height: 300),
            child: buildEmbeddedTweetView(jsonFile),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("test"),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildEmbeddedTweetView(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: EmbeddedTweetView.fromTweet(
                Tweet.fromRawJson(
                  snapshot.data,
                ),
                darkMode: false,
                createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

/*
AAAAAAAAAAAAAAAAAAAAAAbgvQAAAAAAnQKPdi3HcZSBU2qRaNsV0S8XbY8%3DwYgrWOpxpIYF26uhpOdVLF2K3clkB883MxNMsq2vuzw3H8o8YQ
 */
