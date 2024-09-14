import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:learning/authentication/Signup.dart';
import 'package:learning/authentication/login.dart';
import 'package:learning/splash.dart';

class Slid extends StatefulWidget {
  const Slid({super.key});

  @override
  State<Slid> createState() => _SlidState();
}

class _SlidState extends State<Slid> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: false,
        autoScrollDuration: 3000,
        infiniteAutoScroll: false,
        globalHeader: Align(
          alignment: Alignment.topRight,
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60.h,
        ),
        pages: [
          PageViewModel(
              decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800),
                  bodyTextStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp)),
              title: 'Certification and Badges',
              body: 'Earn a certificate after completion of \nevery course.',
              image: Image.asset("assets/b.png")),
          PageViewModel(
              decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800),
                  bodyTextStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp)),
              title: 'Progress Tracking',
              body: 'Check your Progress of every course.',
              image: Image.asset("assets/c.png")),
          PageViewModel(
              decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800),
                  bodyTextStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp)),
              title: 'Offline Access',
              body: 'Make your course available offline.',
              image: Image.asset("assets/d.png")),
          PageViewModel(
              decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800),
                  bodyTextStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp)),
              title: 'Course Catalog',
              body: 'View in which courses you are enrolled.',
              image: Image.asset("assets/e.png")),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: CircleAvatar(
            radius: 20.r,
            backgroundColor: Color(0xD3F8C657),
            child: const Icon(Icons.arrow_forward)),
        done: Container(
            width: 70.w,
            height: 30.h,
            decoration: ShapeDecoration(
                color: Color(0xD3F8C657),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r))),
            child:  Center(
              child: Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            )),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin:  EdgeInsets.all(16.sp),
        controlsPadding: kIsWeb
            ?  EdgeInsets.all(12.0.sp)
            :  EdgeInsets.fromLTRB(8.0.w, 4.0.h, 8.0.w, 4.0.h),
        dotsDecorator:  DotsDecorator(
          size: Size(10.0.sp, 10.0.sp),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0.sp, 10.0.sp),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
          ),
        ),
        dotsContainerDecorator:  ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
          ),
        ),
      ),
    ));
  }
}
