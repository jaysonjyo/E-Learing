import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/video.dart';

class Categorie extends StatefulWidget {
  const Categorie({super.key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  final firestore =
      FirebaseFirestore.instance.collection("Categories").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF477B72),
            )),
        title: Center(
          child: Text(
            "Categories",
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
              color: Color(0xFF1D1B20),
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.24.w,
            )),
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 20.w),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 29.sp,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firestore,
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
                    return ExpandedTileList.builder(
                      itemCount: snapshot.data!.docs.length,
                      maxOpened: 2,
                      reverse: true,
                      itemBuilder: (context, index, con) {
                        return ExpandedTile(
                          theme:  ExpandedTileThemeData(
                            headerColor: Color(0xFFC6D6D3),
                            headerPadding: EdgeInsets.all(24.0.sp),
                            headerSplashColor: Color(0xFFF6C354),
                            //
                            contentBackgroundColor: Colors.white38,
                            contentPadding: EdgeInsets.all(24.0.sp),
                          ),
                          controller: con,
                          title: Text(
                            snapshot.data!.docs[index]["name"],
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w800)),
                          ),
                          content: SizedBox(
                            width: 500.w,
                            height: 250.h,
                            child: ListView.separated(
                              itemCount:
                                  snapshot.data!.docs[index]['course'].length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => Video(
                                                  video: snapshot.data!
                                                          .docs[index]["course"]
                                                      [position]["video"],
                                                  coursename: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                          [position]
                                                          ['coursename']
                                                      .toString(),
                                                  about: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                          [position]['about']
                                                      .toString(),
                                                  image: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                  [position]
                                                  ['img']
                                                      .toString(),
                                                  rating: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                  [position]
                                                  ['rating']
                                                      .toString(),
                                                  id: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                  [position]
                                                  ['id']
                                                      .toString(),
                                                  tutter: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                  [position]
                                                  ['tutter']
                                                      .toString(),
                                                  fee: snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                  [position]
                                                  ['fee']
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
                                              snapshot
                                                  .data!
                                                  .docs[index]["course"]
                                                      [position]["img"]
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
                                                  snapshot
                                                      .data!
                                                      .docs[index]['course']
                                                          [position]["rating"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFF060302),
                                                    fontSize: 17.sp,
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
                                                tapOnlyMode: true,
                                                initialRating: double.parse(
                                                    snapshot
                                                        .data!
                                                        .docs[index]['course']
                                                            [position]
                                                            ["rating"]
                                                        .toString()),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
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
                                            width: 151.70,
                                            child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]["course"]
                                                        [position]["coursename"]
                                                    .toString(),
                                                style:
                                                    GoogleFonts.plusJakartaSans(
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
                                                    .data!
                                                    .docs[index]["course"]
                                                        [position]["tutter"]
                                                    .toString(),
                                                style:
                                                    GoogleFonts.plusJakartaSans(
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
                                            "\$ ${snapshot.data!.docs[index]["course"][position]["fee"].toString()}",
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
                                );
                              },
                              separatorBuilder: (context, position) {
                                return SizedBox(
                                  width: 15.w,
                                );
                              },
                            ),
                          ),
                          onTap: () {
                            debugPrint("tapped!!");
                          },
                          onLongTap: () {
                            debugPrint("looooooooooong tapped!!");
                          },
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
