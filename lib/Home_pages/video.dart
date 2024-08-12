import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/Home_pages/course_videos.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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

  const Video(
      {super.key,
      required this.video,
      required this.coursename,
      required this.about,
      required this.image,
      required this.rating,
      required this.id,
      required this.tutter,
      required this.fee});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late FlickManager flickManager;
  bool favourites = false;
  bool saved = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore_user = FirebaseFirestore.instance
      .collection("users");



  @override
  void initState() {
    Checkfavourite();
    CheckSaved();
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse(widget.video[0]["url"])));
  }
  // payment for any payments
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    firestore_user.doc(auth.currentUser!.uid).update({"premium":true }).then((onValue){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Course_Video(videolist: widget.video)));
    }).onError((Error, StackTrace){
      Fluttertoast.showToast(msg: Error.toString());
    });
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");

  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
//payment ended function



  @override
  void dispose() {
    flickManager.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> Checkfavourite() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final subcollection = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("favourites");
    QuerySnapshot querySnapshot = await subcollection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]["id"].toString() == widget.id.toString()) {
        setState(() {
          favourites = true;
        });
      } else {
        print("not add");
      }
    }
  }

  Future<void> CheckSaved() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final subcollection = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("saves");
    QuerySnapshot querySnapshot = await subcollection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]["id"].toString() == widget.id.toString()) {
        setState(() {
          saved = true;
        });
      } else {
        print("dont try");
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

      final firestoresub2 = FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid.toString())
          .collection("saves");
      final firestoresub3 = FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid.toString())
          .collection("ADD_Cart");
      return Scaffold(
        appBar: AppBar( backgroundColor: Colors.white,),
        backgroundColor: Colors.white,
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 20.h),
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
                              letterSpacing: -0.14.w,
                            )),
                      ),
                      Wrap(
                        children: [
                          IconButton(
                            icon: saved == true
                                ? Icon(
                              Icons.bookmark,
                              size: 30.sp,
                              color: Colors.black,
                            )
                                : Icon(
                              Icons.bookmark_border,
                              size: 30.sp,
                            ),
                            onPressed: () {
                              CheckSaved();
                              if (saved == true) {
                                firestoresub2
                                    .doc(widget.id)
                                    .delete()
                                    .then((onValue) {
                                  setState(() {
                                    saved = false;
                                  });
                                  Fluttertoast.showToast(msg: "Unsaved");
                                });
                              } else {
                                firestoresub2.doc(widget.id).set({
                                  "id": widget.id,
                                  "img": widget.image,
                                  "rating": widget.rating,
                                  "coursename": widget.coursename,
                                  "tutter": widget.tutter,
                                  "fee": widget.fee,
                                  "video": widget.video,
                                  "about": widget.about
                                }).then((onValue) {
                                  setState(() {
                                    saved == true;
                                  });
                                  Fluttertoast.showToast(msg: "Saved");
                                }).onError((error, StackTrace) {
                                  Fluttertoast.showToast(msg: error.toString());
                                });
                              }
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                Checkfavourite();
                                if (favourites == true) {
                                  firestoresub1
                                      .doc(widget.id)
                                      .delete()
                                      .then((onValue) {
                                    setState(() {
                                      favourites = false;
                                    });
                                    Fluttertoast.showToast(msg: "remove");
                                  });
                                } else {
                                  firestoresub1.doc(widget.id).set({
                                    "id": widget.id,
                                    "img": widget.image,
                                    "rating": widget.rating,
                                    "coursename": widget.coursename,
                                    "tutter": widget.tutter,
                                    "fee": widget.fee,
                                    "video": widget.video,
                                    "about": widget.about
                                  }).then((onValue) {
                                    setState(() {
                                      favourites == true;
                                    });
                                    Fluttertoast.showToast(msg: "Added");
                                  }).onError((error, StackTrace) {
                                    Fluttertoast.showToast(
                                        msg: error.toString());
                                  });
                                }
                              },
                              icon: favourites == true
                                  ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30.sp,
                              )
                                  : Icon(
                                Icons.favorite_outline,
                                size: 30.sp,
                                color: Colors.black,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Divider(
                    thickness: 2.sp,
                    height: 2.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h, right: 299.w),
                  child: Text(
                    'About',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                          color: Color(0xFF060302),
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.14.w,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.w, vertical: 20.h),
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
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                  onTap: () async {
                    final ref_updetion = FirebaseFirestore.instance
                        .collection("users").doc(auth.currentUser!.uid.toString());
                    DocumentSnapshot<Map<String,dynamic>>quaryget=await ref_updetion.get();
                    if(quaryget["premium"]==false)
                      {
                    showModalBottomSheet<void>(
                      // context and builder are
                      // required properties in this widget
                      context: context,
                      builder: (BuildContext context) {
                        // we set up a container inside which
                        // we create center column and display text

                        // Returning SizedBox instead of a Container
                        return SizedBox(
                          height: 250.h,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 60.sp,
                                  color: Colors.orange,
                                ),
                                SizedBox(height: 10.h,),
                                Text(textAlign: TextAlign.center,
                                  'Subscribe for Rs.100 and get access to All courses\nand E-Books. Enjoy additional features like \nrefer and earn money.',
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                        color: Color(0xFF060302),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14.w,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: GestureDetector(onTap: () {
                                    Razorpay razorpay = Razorpay();
                                    var options = {
                                      'key': 'rzp_test_gKANZdsNdLqaQs',
                                      'amount': 100,
                                      'name': 'Acme Corp.',
                                      'description': 'Fine T-Shirt',
                                      'retry': {
                                        'enabled': true,
                                        'max_count': 1
                                      },
                                      'send_sms_hash': true,
                                      'prefill': {
                                        'contact': '8888888888',
                                        'email': 'test@razorpay.com'
                                      },
                                      'external': {
                                        'wallets': ['paytm']
                                      }
                                    };
                                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                        handlePaymentErrorResponse);
                                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                        handlePaymentSuccessResponse);
                                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                        handleExternalWalletSelected);
                                    razorpay.open(options);
                                  },
                                    child: Container(
                                      width: 200.w,
                                      height: 50.h,
                                      decoration: ShapeDecoration(
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20.r))),
                                      child: Center(
                                        child: Text(
                                          'Unlock Premium Access',
                                          style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: -0.14.w,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    );}else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              Course_Video(videolist: widget.video)));
                    }
                  },
                  child: Container(
                    width: 250.w,
                    height: 57.h,
                    decoration: ShapeDecoration(
                      color: Color(0xD3F8C657),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
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
                              letterSpacing: 0.36.w,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                GestureDetector(
                  onTap: () {
                    firestoresub3.doc(widget.id).set({
                      "id": widget.id,
                      "img": widget.image,
                      "rating": widget.rating,
                      "coursename": widget.coursename,
                      "tutter": widget.tutter,
                      "fee": widget.fee,
                      "video": widget.video,
                      "about": widget.about
                    }).then((onValue) {
                      Fluttertoast.showToast(msg: "Added");
                    }).onError((error, StackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                    });
                  },
                  child: Container(
                    width: 170.w,
                    height: 57.h,
                    decoration: ShapeDecoration(
                      color: Color(0xD3F8C657),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Center(
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Icon(Icons.shopping_cart_checkout_outlined),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              'Add Cart',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.36.w,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
