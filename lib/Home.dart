import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/categorie.dart';
import 'package:learning/favourites.dart';
import 'package:learning/shoping_cart.dart';
import 'package:learning/video.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final firestore =
        FirebaseFirestore.instance.collection("Categories").snapshots();
    final firestore1 = FirebaseFirestore.instance
        .collection("StudentAlsoSearchfor")
        .snapshots();
    final firestore2 =
        FirebaseFirestore.instance.collection("Top Courses in IT").snapshots();
    final firestore3 =
        FirebaseFirestore.instance.collection("Because You Viewed").snapshots();

    return DoubleBackToExitWidget(
        snackBarMessage: 'Press back again to exit',
        child:Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24.w,
              )),
            ),
            Text(
              'Khan',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                color: Color(0xFF477B72),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24.w,
              )),
            ),

          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.favorite,size: 30.sp,), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Favourites()));

        },),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ShopingCart()));
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 29.sp,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 15.w, top: 20.h),
              child: Row(
                children: [
                  Text (
                    'Categories',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                  SizedBox(
                    width: 220.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Categorie()));
                    },
                    child: Text(
                      'See All',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        color: Color(0xFF1D1B20),
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.18.w,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: 500.w,
                      height: 50.h,
                      child: ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Container(
                              padding:  EdgeInsets.all(10.sp),
                              decoration: ShapeDecoration(
                                shadows: [BoxShadow(
                                color:Colors.grey,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0.r,
                               // spreadRadius: 2.0,
                              ), //BoxShadow
],
                                color: Color(0xFFC6D6D3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(19.r),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:  EdgeInsets.all(8.0.sp),
                                  child: Text(
                                    snapshot.data!.docs[position]["name"],
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.15.h,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return SizedBox(
                            width: 1.w,
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
            Padding(
              padding:  EdgeInsets.only(left: 15.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    'Students Also Search for',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                  SizedBox(
                    width: 116.w,
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 500.w,
              height: 250.h,
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore1,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Video(
                                          video: snapshot
                                              .data!
                                              .docs[position]["video"],
                                          coursename: snapshot.data!
                                              .docs[position]["coursename"]
                                              .toString(),
                                          about: snapshot
                                              .data!.docs[position]["about"]
                                              .toString(), image: snapshot.data!.docs[position]["img"]
                                        .toString(), rating:  snapshot.data!
                                        .docs[position]["rating"]
                                        .toString(), id:  snapshot.data!
                                        .docs[position]["id"]
                                        .toString(), tutter:  snapshot.data!
                                        .docs[position]["tutter"]
                                        .toString(), fee:  snapshot.data!
                                        .docs[position]["fee"]
                                        .toString(),

                                        )));
                              },
                              child: Container(
                                width: 195.w,
                                height: 500.h,
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                      width: 200.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.r),
                                            topLeft: Radius.circular(10.r)),
                                        child: Image.network(
                                          snapshot.data!.docs[position]["img"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 13.w, top: 10.h),
                                      child: Row(
                                        children: [
                                          Opacity( opacity: 0.50,
                                            child: Text(
                                              snapshot.data!
                                                  .docs[position]["rating"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 20.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0.10.h,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 17.sp,
                                            initialRating: double.parse(
                                                snapshot.data!
                                                    .docs[position]["rating"]
                                                    .toString()),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.w, top: 10.h),
                                      child: SizedBox(
                                        width: 151.70.w,
                                        child: Text(
                                            snapshot.data!
                                                .docs[position]["coursename"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 10.w, top: 6.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            snapshot
                                                .data!.docs[position]["tutter"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                                textStyle: TextStyle(
                                              color: Color(0xFF060302),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.14.w,
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 121.w, top: 5.h),
                                      child: Text(
                                        " \$ ${snapshot.data!.docs[position]["fee"].toString()}",
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                          color: Color(0xFF477B72),
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.18.w,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return SizedBox(
                            width: 20.w,
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 15.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    'Top Courses in IT ',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                  SizedBox(
                    width: 177.w,
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 500..w,
              height: 250.h,
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore2,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Video(
                                          video: snapshot
                                              .data!
                                              .docs[position]["video"],
                                          coursename: snapshot.data!
                                              .docs[position]["coursename"]
                                              .toString(),
                                          about: snapshot
                                              .data!.docs[position]["about"]
                                              .toString(),
                                      image: snapshot.data!.docs[position]["img"]
                                          .toString(), rating:  snapshot.data!
                                        .docs[position]["rating"]
                                        .toString(), id:  snapshot.data!
                                        .docs[position]["id"]
                                        .toString(), tutter:  snapshot.data!
                                        .docs[position]["tutter"]
                                        .toString(), fee:  snapshot.data!
                                        .docs[position]["fee"]
                                        .toString(),
                                        )));
                              },
                              child: Container(
                                width: 195.w,
                                height: 500.h,
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                      width: 200.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.r),
                                            topLeft: Radius.circular(10.r)),
                                        child: Image.network(
                                          snapshot.data!.docs[position]["img"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 12.w, top: 10.h),
                                      child: Row(
                                        children: [
                                          Opacity(   opacity: 0.50,
                                            child: Text(
                                              snapshot.data!
                                                  .docs[position]["rating"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 20.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0.10.h,
                                              ),
                                            ),
                                          ),SizedBox(width: 5.w,),
                                          RatingBar.builder(
                                            itemSize: 17.sp,
                                            initialRating: double.parse(
                                                snapshot.data!
                                                    .docs[position]["rating"]
                                                    .toString()),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 20.w, top: 10.h),
                                      child: SizedBox(
                                        width: 151.70.w,
                                        child: Text(
                                            snapshot.data!
                                                .docs[position]["coursename"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 9.w, top: 6.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            snapshot
                                                .data!.docs[position]["tutter"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                                textStyle: TextStyle(
                                              color: Color(0xFF060302),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.14.w,
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 120.w, top: 5.h),
                                      child: Text(
                                        "\$ ${snapshot.data!.docs[position]["fee"].toString()}",
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                          color: Color(0xFF477B72),
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.18.w,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return SizedBox(
                            width: 20.w,
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 15.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    " Because you Viewed",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                  SizedBox(
                    width: 146.w,
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.18.w,
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 500..w,
              height: 250.h,
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore3,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Video(
                                          video: snapshot
                                              .data!
                                              .docs[position]["video"],
                                          coursename: snapshot.data!
                                              .docs[position]["coursename"]
                                              .toString(),
                                          about: snapshot.data!.docs[position]["about"].toString(),
                                      image: snapshot.data!.docs[position]["img"]
                                          .toString(), rating:  snapshot.data!
                                        .docs[position]["rating"]
                                        .toString(), id:  snapshot.data!
                                        .docs[position]["id"]
                                        .toString(), tutter:  snapshot.data!
                                        .docs[position]["tutter"]
                                        .toString(), fee:  snapshot.data!
                                        .docs[position]["fee"]
                                        .toString(),
                                        )));
                              },
                              child: Container(
                                width: 195.w,
                                height: 500.h,
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                      width: 200.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.r),
                                            topLeft: Radius.circular(10.r)),
                                        child: Image.network(
                                          snapshot.data!.docs[position]["img"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 13.w, top: 10.h),
                                      child: Row(
                                        children: [
                                          Opacity(   opacity: 0.50,
                                            child: Text(
                                              snapshot.data!
                                                  .docs[position]["rating"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 20.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0.10.h,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 17.sp,
                                            initialRating: double.parse(
                                                snapshot.data!
                                                    .docs[position]["rating"]
                                                    .toString()),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 20.w, top: 10.h),
                                      child: SizedBox(
                                        width: 151.70.w,
                                        child: Text(
                                            snapshot.data!
                                                .docs[position]["coursename"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                color: Color(0xFF060302),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          left: 9.w, top: 6.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            snapshot
                                                .data!.docs[position]["tutter"]
                                                .toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                                textStyle: TextStyle(
                                              color: Color(0xFF060302),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.14.w,
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 120.w, top: 5.h),
                                      child: Text(
                                        "\$ ${snapshot.data!.docs[position]["fee"].toString()}",
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                          color: Color(0xFF477B72),
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.18.w,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) {
                          return SizedBox(
                            width: 20.w,
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),)
    );
  }
}
