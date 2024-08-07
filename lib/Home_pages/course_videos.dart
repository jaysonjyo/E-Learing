import 'package:chewie/chewie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Course_Video extends StatefulWidget {
  final List<dynamic> videolist;

  const Course_Video({super.key, required this.videolist});

  @override
  State<Course_Video> createState() => _Course_VideoState();
}

class _Course_VideoState extends State<Course_Video> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  int curentindex = 0;

  _initializeplay(String videoPath) {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoPath))
          ..initialize().then((_) {
            setState(() {
              chewieController = ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: videoPlayerController.value.aspectRatio,
                autoPlay: true,
                looping: false,
              );
            });
          });
  }

  void changevideo(String videopath, int index) {
    setState(() {
      curentindex = index;
    });
    videoPlayerController.pause();
    videoPlayerController.dispose();
    chewieController?.dispose();
    _initializeplay(videopath);
  }

  @override
  void initState() {
    _initializeplay(widget.videolist[curentindex]['url']);
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity.w,
                height: 250.h,
                color: Colors.black,
                child: chewieController == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Chewie(
                        controller: chewieController!,
                      )),
            SizedBox(
              width: 500.w,
              height: 600.h,
              child: ListView.separated(
                itemCount: widget.videolist.length,
                itemBuilder: (context, position) {
                  return Padding(
                    padding:  EdgeInsets.only(top: 10.h,left: 10.w,right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        changevideo(widget.videolist[position]["url"], position);
                      },
                      child: Container(
                        width: 200.w,height: 60.h,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                )),
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              height: 60.h,
                              decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(13.r))),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.videolist[position]["title"]
                                        .toString(),
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                      color: Color(0xFF060302),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.14.w,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "\ Time  ${ widget.videolist[position]['Duration'].toString()}",
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                      color: Color(0xFF060302),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.14.w,
                                    )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  );

                }, separatorBuilder: (BuildContext context, int index) { return
              Padding(
                padding:  EdgeInsets.only(
                    left: 20.w,right: 10.w,top: 6.h),
                child: Divider(thickness: 1.sp
                  ,height: 12.h,),
              );},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
