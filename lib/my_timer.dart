import 'dart:async';
import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  // int totalTime = 60;
  int times = 60; //1 min
  late Timer timer;
  String timeView = '0:00:00';
  bool isRunning = false;

  void timeStart() {
    if (isRunning) {
      timeStop();
      setState(() {
        isRunning = !isRunning;
      });
    } else {
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            timeView = Duration(seconds: times).toString().split('.').first;
            times--;
            if (times < 0) {
              timeStop();
              setState(() {
                isRunning = !isRunning;
              });
            }
          });
        }
      });
    }

    //1초마다 1씩 감소
  }

  void timeStop() {
    timer.cancel();
  }

  void timeReset() {
    setState(() {
      timeStop();
      times = 60;
      isRunning = false;
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  void addTime(int sec) {
    times += sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'My timer',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                )),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    timeButton(sec: 60, color: Colors.amber),
                    timeButton(
                        sec: 30, color: Color.fromARGB(255, 197, 194, 184)),
                    timeButton(
                        sec: -60, color: Color.fromARGB(255, 53, 47, 28)),
                    timeButton(
                        sec: -30, color: Color.fromARGB(255, 238, 197, 74)),
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      timeView,
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        IconButton(
                          onPressed: timeStart,
                          icon: Icon(Icons.pause_circle_rounded),
                          iconSize: 50,
                        )
                      else
                        IconButton(
                          onPressed: timeStart,
                          icon: Icon(
                            Icons.play_circle_fill_rounded,
                          ),
                          iconSize: 50,
                        ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: timeReset,
                        icon: Icon(
                          Icons.restore_rounded,
                        ),
                        iconSize: 50,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector timeButton({required int sec, required Color color}) {
    return GestureDetector(
      onTap: () => addTime(sec),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: Text('$sec')),
      ),
    );
  }
}
