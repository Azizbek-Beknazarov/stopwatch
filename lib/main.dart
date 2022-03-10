import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  // logic

  int second = 0, minute = 0, hour = 0;
  String digitSecond = '00', digitminute = '00', digitHour = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  //creating stop function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //creating reset function
  void resetTime() {
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hour = 0;
      digitSecond = '00';
      digitminute = '00';
      digitHour = '00';
      started = false;
    });
  }

  // add Laps
  void addLaps() {
    String lap = '$digitHour:$digitminute:$digitSecond';
    setState(() {
      laps.add(lap);
    });
  }

  // start timer function
  void startTimer() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localS = second + 1, localM = minute, localH = hour;

      if (localS > 59) {
        if (localM > 59) {
          localH++;
          localM = 0;
        } else {
          localM++;
          localS = 0;
        }
      }
      setState(() {
        second = localS;
        minute = localM;
        hour = localH;

        digitSecond = (second >= 10) ? '$second' : '0$second';
        digitminute = (minute >= 10) ? '$minute' : '0$minute';
        digitHour = (hour >= 10) ? '$hour' : '0$hour';
      });
    });
  }

  //reset laps
  void resetLap() {
    setState(() {
      laps.clear();
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              Center(
                child: Text(
                  'Stop Watch App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  '$digitHour:$digitminute:$digitSecond',
                  style: TextStyle(fontSize: 78, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(12)),
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap №${index + 1}",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: laps.length,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? startTimer() : stop();
                    },
                    shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                    child: Text(
                      (!started) ? "Start" : 'Pause',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(
                      Icons.flag,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                  RawMaterialButton(
                    onPressed: () {
                      resetTime();
                    },
                    fillColor: Colors.red,
                    shape: StadiumBorder(),
                    child: Text(
                      'Reset Time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      resetLap();
                    },
                    fillColor: Colors.red,
                    shape: StadiumBorder(),
                    child: Text(
                      'Reset Lap',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                    ],
                  ),
                  //
                ],
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
