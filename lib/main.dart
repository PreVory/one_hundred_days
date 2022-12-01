import 'dart:ui';

import 'package:flutter/material.dart';
import 'models/models.dart';
import 'constants/consts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const OneHundredDaysApp());
}

class OneHundredDaysApp extends StatelessWidget {
  const OneHundredDaysApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(top: 32),
        child: MainPage(),
      )),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<int> containerList = List.generate(100, (index) => index + 1);
  List<int> pressedItems = [];

  int selectedCard = -1;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: containerList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
          ),
          itemBuilder: (context, index) {
            index = index++;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (pressedItems.contains(index) && pressedItems.last == index) {
                    pressedItems.remove(index);
                  } else {
                    pressedItems.add(index);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: pressedItems.contains(index)
                        ? Colors.green
                        : Color.fromARGB(255, index * 1, index * 1, index),
                    borderRadius: BorderRadius.circular(50)),
                width: 50,
                height: 50,
                child: Center(
                    child: Text(
                        (index+1).toString(),
                )),
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Align(alignment: Alignment.bottomCenter, child: ElevatedButton(onPressed: () {
          setState(() {
            pressedItems.clear();
          });

        }, child: Text('Clear')),),
      )],
    );
  }
}
