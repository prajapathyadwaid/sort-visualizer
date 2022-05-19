import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sort Visualizer',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  late List randomInt;
  late List selectInt;
  late List insertInt;
  late List bubbleInt;
  bool isSorting = false;

  @override
  initState() {
    newList();
    super.initState();
  }

  List randomgenerator() {
    Random rng = Random();
    List l = List.generate(400, (_) => rng.nextInt(1000));
    return l;
  }

  refresh() {
    if (!isSorting) newList();
    isSorting = false;
  }

  newList() {
    setState(() {
      randomInt = randomgenerator();
      selectInt = [...randomInt];
      insertInt = [...randomInt];
      bubbleInt = [...randomInt];
    });
  }

  selectionSort(List L) async {
    var n = L.length;
    for (var i = 0; i < n - 1; i++) {
      var indexMin = i;
      for (var j = i + 1; j < n; j++) {
        if (L[j] < L[indexMin]) {
          indexMin = j;
        }
      }
      if (indexMin != i) {
        var temp = L[i];
        L[i] = L[indexMin];
        L[indexMin] = temp;
      }
      setState(() {
        selectInt = L;
      });
      if (!isSorting) {
        newList();
        break;
      }
      await Future.delayed(const Duration(milliseconds: 5));
    }
    isSorting = false;
  }

  insertionSort(List list) async {
    for (int j = 1; j < list.length; j++) {
      int key = list[j];
      int i = j - 1;
      while (i >= 0 && list[i] > key) {
        list[i + 1] = list[i];
        i = i - 1;
        list[i + 1] = key;
      }
      setState(() {
        insertInt = list;
      });
      if (!isSorting) {
        newList();
        break;
      }
      await Future.delayed(const Duration(milliseconds: 5));
    }
    isSorting = false;
  }

  bubbleSort(List array) async {
    int lengthOfArray = array.length;

    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (array[j] > array[j + 1]) {
          int temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
        }
      }
      setState(() {
        bubbleInt = array;
      });
      if (!isSorting) {
        newList();
        break;
      }
      await Future.delayed(const Duration(milliseconds: 5));
    }
    isSorting = false;
  }

  sort() {
    isSorting = true;
    bubbleSort(bubbleInt);
    insertionSort(insertInt);
    selectionSort(selectInt);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 100;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sort Visualizer",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xffffcb74),
        foregroundColor: const Color(0xff111111),
        actions: [
          IconButton(
              onPressed: sort, icon: const Icon(Icons.play_arrow_rounded)),
          IconButton(
              onPressed: refresh, icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Container(
          height: height + 100,
          width: width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: height / 2,
                    width: width / 2,
                    color: const Color(0xff111111),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 400; i++)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.00035),
                            width: (width / 2) * 0.001,
                            height: (height / 2) * (randomInt[i] / 1000),
                            color: const Color(0xffffe6bc),
                          )
                      ],
                    ),
                  ),
                  Container(
                    height: height / 2,
                    width: width / 2,
                    color: const Color(0xff111111),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 400; i++)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.00035),
                            width: (width / 2) * 0.001,
                            height: (height / 2) * (selectInt[i] / 1000),
                            color: const Color(0xffffe6bc),
                          )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 22,
                width: width,
                color: const Color(0xff2f2f2f),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: width / 2,
                      height: 22,
                      child: const Text(
                        "Orginal List",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width / 2,
                      height: 22,
                      child: const Text(
                        "Selection Sort",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: height / 2,
                    width: width / 2,
                    color: const Color(0xff111111),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 400; i++)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.00035),
                            width: (width / 2) * 0.001,
                            height: (height / 2) * (bubbleInt[i] / 1000),
                            color: const Color(0xffffe6bc),
                          )
                      ],
                    ),
                  ),
                  Container(
                    height: height / 2,
                    width: width / 2,
                    color: const Color(0xff111111),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 400; i++)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.00035),
                            width: (width / 2) * 0.001,
                            height: (height / 2) * (insertInt[i] / 1000),
                            color: const Color(0xffffe6bc),
                          )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 22,
                width: width,
                color: const Color(0xff2f2f2f),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: width / 2,
                      height: 22,
                      child: const Text(
                        "Bubble Sort",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width / 2,
                      height: 22,
                      child: const Text(
                        "Insertion Sort",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
