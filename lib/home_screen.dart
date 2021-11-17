import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late AnimationController controller;

  double valueCircular = 0;

  @override
  void initState() {

    // controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(minutes: 1),
    // )..addListener(() {
    //   setState(() {
    //     valueCircular = controller.value;
    //   });
    // });
    // controller.repeat(reverse: false);
    super.initState();
  }

  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          _start = 60;
          fab = Icon(Icons.pause,);
          controller = AnimationController(
            vsync: this,
            duration: Duration(minutes: 1),
          )..addListener(() {
            setState(() {
              valueCircular = controller.value;
            });
          });
          controller.repeat(reverse: false);

        });

      } else {
        setState(() {
          _start--;
        });
      }
    },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer!.cancel();
    super.dispose();
  }

  Icon fab = Icon(Icons.play_arrow,);
  int k = 0;
  int firstTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Center(
              child: Text("$_start", style: TextStyle(fontSize: 125, color: Colors.black.withOpacity(0.5)),),
            ),
            Container(
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  width: 300,
                  child: CircularProgressIndicator(
                    value: valueCircular,
                    strokeWidth: 15,
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // Add your onPressed code here!
        setState(() {
          if (k == 0 && firstTime == 0) {
            controller = AnimationController(
              vsync: this,
              duration: Duration(minutes: 1),
            )..addListener(() {
              setState(() {
                valueCircular = controller.value;
              });
            });
            controller.repeat(reverse: false);
            fab = Icon(Icons.pause,);
            k = 1;
            startTimer();
            firstTime = 1;
          }
          else if (k == 0 && firstTime != 0) {
            fab = Icon(Icons.pause,);
            k = 1;
            startTimer();
            controller.repeat(reverse: false);
            controller.forward();
            firstTime = 1;
          } else {
            fab = Icon(Icons.play_arrow);
            k = 0;
            controller.stop();
            _timer!.cancel();
          }
        });

        },
        child: Icon(k == 1 ? Icons.pause : Icons.play_arrow,),
        backgroundColor: Colors.blue,
      ),
    );
  }
}