import 'package:flutter/material.dart';

void main() {
  runApp(const OneHundredDaysApp());
}

class OneHundredDaysApp extends StatelessWidget {
  const OneHundredDaysApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<int> containerList = List.generate(100, (index) => index + 1);
  List<int> pressedItems = [];
  int focusedIndex = 0;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              itemCount: containerList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                index = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      focusedIndex = index;
                      if (pressedItems.contains(index)) {
                        List<int> toRemove = [];
                        for (int i in pressedItems) {
                          if (i > index) {
                            toRemove.add(i);
                          }
                        }
                        pressedItems.removeWhere((e) => toRemove.contains(e));
                      } else {
                        for (int i = 1; i <= index; i++) {
                          if (!(pressedItems.contains(i))) {
                            pressedItems.add(i);
                          }
                        }
                      }
                      controller.animateTo(pressedItems.isNotEmpty
                          ? (pressedItems.last + 0.01) / 100
                          : 0);
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
                      (index).toString(),
                    )),
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                    value: controller.value, color: Colors.green, minHeight: 7),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        focusedIndex = 0;
                        pressedItems.clear();
                        controller.animateTo(pressedItems.isNotEmpty
                            ? (pressedItems.last + 0.01) / 100
                            : 0);
                      });
                    },
                    child: const Text('Clear')),
                Text('$focusedIndex из 100'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
