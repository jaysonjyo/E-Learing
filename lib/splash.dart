import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/slid.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),(){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Slid()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
SizedBox(height: 250.h,),
Stack(
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 80,left: 15),
      child: SizedBox(width: 400.w,height: 120.h,
          child: Image.asset("assets/splash.png")),
    ),
Padding(
  padding: const EdgeInsets.only(top: 20),
  child: RotationTransition(turns: AlwaysStoppedAnimation(-10/320),
    child: SizedBox(
        width:120.w,height:150.h,child: Image.asset("assets/a.png")),
  ),
)

  ],
)
      ],),
    );
  }
}
