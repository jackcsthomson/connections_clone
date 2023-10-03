import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//* * Set Groupings and Hint Text
List green = ['CLOCK', 'MAIL', 'MAPS', 'NOTES'];
List yellow = ['BOW', 'KNEEL', 'SALUTE', 'STAND'];
List blue = ['DOWN', 'FUR', 'SCALES', 'SHELL'];
List purple = ['ARROW', 'DOG', 'FINGER', 'HINT'];

String greenAnswer = 'IPHONE APPS';
String yellowAnswer = 'WAYS TO SHOW RESPECT';
String blueAnswer = 'ANIMAL COVERINGS';
String purpleAnswer = '"POINTERS"';

Color greenColor = const Color(0xFFA0C35A);
Color yellowColor = const Color(0xFFF9DF6D);
Color blueColor = const Color(0xFFB0C4EF);
Color purpleColor = const Color(0xFFBA81C5);
Color selected = const Color(0XFF5A594E);
Color itemGrey = const Color(0xFFEFEFE6);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return MaterialApp(
      title: 'NYT Connections',
      theme: ThemeData(
        fontFamily: 'Libre Franklin',
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: itemGrey,
            minimumSize: orientation == Orientation.portrait
                ? ui.Size(width / 4.75, height / 10)
                : ui.Size(width / 10, height / 10),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List words = green + yellow + blue + purple;
  List isSelected = [];
  int mistakes = 0;
  List correctGroups = [];
  List correctWords = [];
  bool appLaunch = true;

  void _wordButtonPress(String word) {
    setState(() {
      if (((isSelected.contains(word)) || (isSelected.length != 4)) &&
          (mistakes != 4) &&
          !(correctWords.contains(word))) {
        if (isSelected.contains(word)) {
          isSelected.remove(word);
        } else {
          isSelected.add(word);
        }
      }
    });
  }

  void _onSubmit() {
    setState(() {
      isSelected.sort();
      if (listEquals(isSelected, green)) {
        correctGroups.add('GREEN');
        correctWords.add(green[0]);
        correctWords.add(green[1]);
        correctWords.add(green[2]);
        correctWords.add(green[3]);
      } else if (listEquals(isSelected, yellow)) {
        correctGroups.add('YELLOW');
        correctWords.add(yellow[0]);
        correctWords.add(yellow[1]);
        correctWords.add(yellow[2]);
        correctWords.add(yellow[3]);
      } else if (listEquals(isSelected, blue)) {
        correctGroups.add('BLUE');
        correctWords.add(blue[0]);
        correctWords.add(blue[1]);
        correctWords.add(blue[2]);
        correctWords.add(blue[3]);
      } else if (listEquals(isSelected, purple)) {
        correctGroups.add('PURPLE');
        correctWords.add(purple[0]);
        correctWords.add(purple[1]);
        correctWords.add(purple[2]);
        correctWords.add(purple[3]);
      } else {
        mistakes++;
      }
      isSelected = [];
    });
  }

  correctColour(String word) {
    if (green.contains(word)) {
      return greenColor;
    } else if (yellow.contains(word)) {
      return yellowColor;
    } else if (blue.contains(word)) {
      return blueColor;
    } else if (purple.contains(word)) {
      return purpleColor;
    }
  }

  Widget wordButton(String word, Orientation orientation) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: correctWords.contains(word)
            ? correctColour(word)
            : isSelected.contains(word)
                ? selected
                : itemGrey,
      ),
      onPressed: () {
        _wordButtonPress(word);
      },
      child: Text(
        word,
        style: TextStyle(
          fontSize: orientation == Orientation.portrait ? 12 : 16,
          fontWeight: FontWeight.w900,
          color: isSelected.contains(word) ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double spacer = orientation == Orientation.portrait ? 5 : 10;
    double fontSize = orientation == Orientation.portrait ? 12 : 16;
    if (appLaunch) {
      words.shuffle();
      appLaunch = false;
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: spacer),
          Text(
            'Create four groups of four!',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: spacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wordButton(words[0], orientation),
              SizedBox(width: spacer),
              wordButton(words[1], orientation),
              SizedBox(width: spacer),
              wordButton(words[2], orientation),
              SizedBox(width: spacer),
              wordButton(words[3], orientation),
            ],
          ),
          SizedBox(height: spacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wordButton(words[4], orientation),
              SizedBox(width: spacer),
              wordButton(words[5], orientation),
              SizedBox(width: spacer),
              wordButton(words[6], orientation),
              SizedBox(width: spacer),
              wordButton(words[7], orientation),
            ],
          ),
          SizedBox(height: spacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wordButton(words[8], orientation),
              SizedBox(width: spacer),
              wordButton(words[9], orientation),
              SizedBox(width: spacer),
              wordButton(words[10], orientation),
              SizedBox(width: spacer),
              wordButton(words[11], orientation),
            ],
          ),
          SizedBox(height: spacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wordButton(words[12], orientation),
              SizedBox(width: spacer),
              wordButton(words[13], orientation),
              SizedBox(width: spacer),
              wordButton(words[14], orientation),
              SizedBox(width: spacer),
              wordButton(words[15], orientation),
            ],
          ),
          SizedBox(height: spacer * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mistakes Remaining:',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              for (int i = 0; i < 4 - mistakes; i++)
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Icon(Icons.circle, size: 14, color: selected),
                  ],
                ),
            ],
          ),
          SizedBox(height: spacer * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(
                    () {
                      words.shuffle();
                    },
                  );
                },
                child: Text(
                  'Shuffle',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: spacer),
              OutlinedButton(
                  onPressed: () {
                    setState(
                      () {
                        isSelected = [];
                      },
                    );
                  },
                  child: Text(
                    'Deselect All',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              SizedBox(width: spacer),
              OutlinedButton(
                onPressed: () {
                  if (isSelected.length == 4) {
                    _onSubmit();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: isSelected.length == 4 ? Colors.black : itemGrey,
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: isSelected.length == 4 ? Colors.black : itemGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
