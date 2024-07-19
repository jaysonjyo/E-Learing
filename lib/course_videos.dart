import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Course_Video extends StatefulWidget {
  const Course_Video({super.key});

  @override
  State<Course_Video> createState() => _Course_VideoState();
}

class _Course_VideoState extends State<Course_Video> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(
              "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
        ));
  }
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: Column(children: [ Container(
    width: double.infinity.w,
    height: 250.h,
    child: FlickVideoPlayer(flickManager: flickManager),
  ),
    SizedBox(width: 500..w,height: 600.h,
      child:ListView.builder(
        itemCount: 20,
        itemBuilder: (context, position) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Container(width: 199.w,height: 150.h,decoration: ShapeDecoration(color: Colors.black,shape: RoundedRectangleBorder()),
                child: FlickVideoPlayer(flickManager: flickManager,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        Text(
                          ' Video',
                          style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                            color: Color(0xFF060302),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.14,)
                          ),
                        ),SizedBox(height: 5.h,),
                        Text(
                          ' 6.20m',
                          style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                            color: Color(0xFF060302),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.14,)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),

    ),
  ],),
),

    );
  }
}
