

import 'dart:async';
import 'dart:math';
import 'package:covid_app/homescreen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
 late final AnimationController controller=AnimationController( duration: Duration(seconds: 3),
vsync: this)..repeat();
 void dispose(){
   super.dispose();
   controller.dispose();
 }
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>home()));

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
child:  Container(
  height: 400,
  width: 400,
  child: Center(child: Image(image: AssetImage("assets/images/coronavirus.jpg"),),),
),
                animation:controller , builder: (BuildContext context,Widget? child){
return Transform.rotate(angle: controller.value* 0.2*pi, alignment: Alignment.center,
  child: child,



);
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height* .08,
            ),
            Align(
              alignment: Alignment.center,
                child: Text("Covid 19\n Tracker App",style: TextStyle(fontSize: 30,color: Colors.white),))
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
