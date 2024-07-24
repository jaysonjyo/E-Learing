import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/course_videos.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
   final String video;
   final String coursename;
   final String about;
  const Video({super.key, required this.video, required this.coursename, required this.about});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.video)

    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity.w,
                height: 250.h,
                child: FlickVideoPlayer(flickManager: flickManager),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.coursename,
                      style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                        color: Color(0xFF060302),
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,)
                      ),
                    ),
                    Icon(Icons.save)
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Divider(thickness: 2,height: 2.h,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,right: 280),
                child: Text(
                  'About',
                  style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                    color: Color(0xFF060302),
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.14,)
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: ReadMoreText(
              widget.about,style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(fontSize: 16.sp),),
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'read more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //   child: Text(
              //     widget.about,
              //     style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
              //       color: Color(0xFF545454),
              //       fontSize: 16.sp,
              //       fontWeight: FontWeight.w500,
              //       letterSpacing: -0.14,)
              //     ),
              //   ),
              // ),
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
      ),
    );
  }
}
