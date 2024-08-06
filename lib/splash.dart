import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/Bottam_Navigationbar.dart';
import 'package:learning/Home.dart';
import 'package:learning/slid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),()async{
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("Token")){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>BottamNavigation()),(route)=> false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Slid()),(route)=> false);
      }
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
      padding:  EdgeInsets.only(top: 80.h,left: 15.w),
      child: SizedBox(width: 400.w,height: 120.h,
          child: Image.asset("assets/splash.png")),
    ),
Padding(
  padding:  EdgeInsets.only(top: 20.h),
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
