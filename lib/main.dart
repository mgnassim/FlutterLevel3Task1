import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'Game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterLevel3Task1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          headline2: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
      ),
      home: const HomeScreen(title: 'FlutterLevel3Task1'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.title}) : super(key: key);

  final title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome to the Games Rating app!',
                style: Theme.of(context).textTheme.headline1),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Click START to start rating :)',
                  style: Theme.of(context).textTheme.headline2),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RatingScreen(
                                  title: 'FlutterLevel3Task1')),
                        );
                      });
                    },
                    child: const Text('START')),
              ),
            )
          ]),
    );
  }
}

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key, this.title}) : super(key: key);

  final title;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late double ratingOfUser;
  String randomGeneratedGame = returnRandomGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Rate the following game from 1 to 5 stars!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(randomGeneratedGame,
                  style: Theme.of(context).textTheme.headline2),
            ),
            RatingBar.builder(
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.blue,
              ),
              onRatingUpdate: (double value) {
                ratingOfUser = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SummaryScreen(
                                  game: Game(randomGeneratedGame, ratingOfUser),
                                  title: 'FlutterLevel3Task1')),
                        );
                      });
                    },
                    child: const Text('TO SUMMARY')),
              ),
            )
          ]),
    );
  }
}

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key, this.title, required this.game})
      : super(key: key);

  final title;
  final Game game;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  'You rated ${widget.game.title} with ${widget.game.ratingvalue} stars! Thanks?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen(
                                  title: 'FlutterLevel3Task1')),
                        );
                      });
                    },
                    child: const Text('START OVER')),
              ),
            )
          ]),
    );
  }
}

String returnRandomGame() {
  List<String> randomGames = [
    "Red Dead Redemption 2",
    "Rocket League",
    "Shadow of the Tombraider"
  ];
  return randomGames.elementAt(Random().nextInt(randomGames.length));
}
