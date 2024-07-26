import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/course_videos.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final List<dynamic> video;
  final String coursename;
  final String about;
  final String image;
  final String rating;
  final String id;
  final String tutter;
  final String fee;


  const Video({super.key,
    required this.video,
    required this.coursename,
    required this.about,
    required this.image,
    required this.rating,
    required this.id,
    required this.tutter,
    required this.fee

  });

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late FlickManager flickManager;
bool favourites=false;
bool saved =false;
  @override
  void initState() {
    Checkfavourite();
    CheckSaved();
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(widget.video[0]["url"])));
  }

  @override
  void dispose() {
    flickManager.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> Checkfavourite () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final subcollection = FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid).collection("favourites");
    QuerySnapshot querySnapshot=await subcollection.get();
    for(int i=0; i<querySnapshot.docs.length;i++){
      if(querySnapshot.docs[i]["id"].toString()==widget.id.toString()){
        setState(() {
          favourites=true;
        });
      }else{
        print ("not add");
      }

    }
  }


  Future<void> CheckSaved () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final subcollection = FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid).collection("saves");
    QuerySnapshot querySnapshot=await subcollection.get();
    for(int i=0; i<querySnapshot.docs.length;i++){
      if(querySnapshot.docs[i]["id"].toString()==widget.id.toString()){
        setState(() {
          saved=true;
        });
      }else{
        print ("dont try");
      }

    }
  }
  @override
  Widget build(BuildContext context) {

    FirebaseAuth auth = FirebaseAuth.instance;
    final firestoresub1 = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .collection('favourites');

    final firestoresub2  =FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid.toString()).collection("saves");

    return Scaffold(
      appBar: AppBar(),
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.coursename,
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                            color: Color(0xFF060302),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.14,
                          )),
                    ),

                    Wrap(
                      children: [
                        IconButton(
                          icon: saved== true? Icon(Icons.bookmark,size: 30.sp,color: Colors.black,):Icon(Icons.bookmark_border,size: 30.sp,), onPressed: () {
                         CheckSaved();
                          if(saved==true){
                            firestoresub2.doc(widget.id).delete().then((onValue) {

                              setState(() {
                                saved=false;
                              });
                              Fluttertoast.showToast(msg: "remove");
                            });
                          }else{
                          firestoresub2.doc(widget.id).set({
                            "id": widget.id,
                            "img": widget.image,
                            "rating": widget.rating,
                            "coursename": widget.coursename,
                            "tutter": widget.tutter,
                            "fee": widget.fee,
                            "video":widget.video,
                            "about":widget.about}).then((onValue) {
                            setState(() {
                            saved==true;
                            });
                            Fluttertoast.showToast(msg: "Added");
                            }).onError((error, StackTrace) {
                            Fluttertoast.showToast(msg: error.toString());
                            });}}
                          ,),
                        IconButton(
                            onPressed: () {
                              Checkfavourite();
                              if(favourites==true){
                                firestoresub1.doc(widget.id).delete().then((onValue) {

                                  setState(() {
                                    favourites=false;
                                  });
                                  Fluttertoast.showToast(msg: "remove");
                                });
                              }else{
                              firestoresub1.doc(widget.id).set({
                                "id": widget.id,
                                "img": widget.image,
                                "rating": widget.rating,
                                "coursename": widget.coursename,
                                "tutter": widget.tutter,
                                "fee": widget.fee,
                                "video":widget.video,
                                "about":widget.about
                              }).then((onValue) {
                                setState(() {
                                  favourites==true;
                                });
                                Fluttertoast.showToast(msg: "Added");
                              }).onError((error, StackTrace) {
                                Fluttertoast.showToast(msg: error.toString());
                              });}
                            },
                            icon: favourites==true ? Icon(Icons.favorite,color: Colors.red,size: 30.sp,):
                            Icon(Icons.favorite_outline,size: 30.sp,color: Colors.black,)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Divider(
                  thickness: 2,
                  height: 2.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 299),
                child: Text(
                  'About',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                        color: Color(0xFF060302),
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      )),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: ReadMoreText(
                  widget.about,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(fontSize: 16.sp),
                  ),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'read more',
                  trimExpandedText: 'Show less',
                  moreStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Course_Video()));
                },
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
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.36,
                          )),
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
