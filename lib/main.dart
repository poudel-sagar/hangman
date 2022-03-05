import 'package:flutter/material.dart';
import 'package:hangman/ui/colors.dart';
import 'package:hangman/ui/widget/figure_image.dart';
import 'package:hangman/ui/widget/letter.dart';
import 'package:hangman/util/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = "sagar";

  //making a list of alphabet that we use in our keyboard
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Hangman Game"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                //last element in stack appears topmost position in screen
                figureImage(Game.tries >= 0, "assets/hang.png"),
                figureImage(Game.tries >= 1, "assets/head.png"),
                figureImage(Game.tries >= 2, "assets/body.png"),
                figureImage(Game.tries >= 3, "assets/ra.png"),
                figureImage(Game.tries >= 4, "assets/la.png"),
                figureImage(Game.tries >= 5, "assets/r1.png"),
                figureImage(Game.tries >= 6, "assets/l1.png"),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedchar.contains(e.toUpperCase())))
                .toList(),
          ),

          //game keyboard started here
          SizedBox(
              width: double.infinity,
              height: 250.0,
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                padding: EdgeInsets.all(8.0),
                children: alphabets.map((e) {
                  return RawMaterialButton(
                    onPressed: Game.selectedchar.contains(e)?null:(){
                      setState(() {
                              Game.selectedchar.add(e);
                              print(Game.selectedchar);
                              if(!word.split('').contains(e.toUpperCase())){
                                Game.tries++;
                              }
                                            });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.white, fontSize: 30.0,fontWeight: FontWeight.bold),
                    ),
                    fillColor: Game.selectedchar.contains(e)
                        ? Colors.black87
                        : Colors.blue,
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}
