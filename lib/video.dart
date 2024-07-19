import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/course_videos.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity.w,
              height: 250.h,
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 210,top: 50),
              child: Text(
                'Stephen Moris',
                style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                  color: Color(0xFF060302),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.14,)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,right: 242),
              child: Text(
                'Stephen Moris',
                style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                  color: Color(0xFF060302),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.14,)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 135,top: 10),
              child: SizedBox(width: 200.w,height: 20.h,
                child: Text(
                  'get start & any courses',
                  style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                    color: Color(0xFF545454),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.14,)
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Course_Video()));},
              child: Container(
                width: 250.w,
                height: 57.h,
                decoration: ShapeDecoration(
                  color: Color(0xD3F8C657),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Start Course!',
                    style: GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.36,)
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
