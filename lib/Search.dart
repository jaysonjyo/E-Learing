import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/Home_pages/shoping_cart.dart';
import 'package:learning/Home_pages/video.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final firestore = FirebaseFirestore.instance
      .collection("StudentAlsoSearchfor")
      .snapshots();
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DoubleBackToExitWidget(
      snackBarMessage: 'Press back again to exit',
      child:  Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r))),
              child: TextField(
                controller: search,
                style: TextStyle(color: Colors.black,decorationThickness: 0.sp),
                decoration: InputDecoration(
                    hintText: "Search....",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none)),
                onSubmitted: (value){
                  setState(() {

                  });
                },onChanged: (value){
                  setState(() {

                  });
              },
              ),
            ),
            actions: [
              Padding(
                padding:  EdgeInsets.only(right: 5.w),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => ShopingCart()));
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 29.sp,color: Colors.white,
                  ),
                ),
              )
            ],
          ), backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("error"),
                  );
                }
                if (snapshot.hasData) {
                  return SizedBox(
                    width: 500.w,
                    height: 700.h,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 300 / 390,
                      shrinkWrap: true,
                      children: List.generate(
                        snapshot.data!.docs.length,
                            (index) {
                          if(search.text.toLowerCase()==snapshot.data!.docs[index]["coursename"].toString().toLowerCase()){
                            print("hello");
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Video(
                                        video: snapshot.data!.docs[index]["video"],
                                        coursename: snapshot
                                            .data!.docs[index]["coursename"]
                                            .toString(),
                                        about: snapshot.data!.docs[index]["about"]
                                            .toString(),
                                        image: snapshot.data!.docs[index]["img"]
                                            .toString(),
                                        rating: snapshot.data!.docs[index]["rating"]
                                            .toString(),
                                        id: snapshot.data!.docs[index]["id"]
                                            .toString(),
                                        tutter: snapshot.data!.docs[index]["tutter"]
                                            .toString(),
                                        fee: snapshot.data!.docs[index]["fee"]
                                            .toString())));
                              },
                              child: Container(
                                width: 200.w,
                                height: 500.h,
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.r))),
                                child: Padding(
                                  padding:  EdgeInsets.all(5.0.sp),
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
                                            snapshot.data!.docs[index]["img"]
                                                .toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            left: 10.w, top: 10.h),
                                        child: Row(
                                          children: [
                                            Opacity(opacity: 0.50,
                                              child: Text(
                                                snapshot.data!.docs[index]["rating"]
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
                                              initialRating: double.parse(snapshot
                                                  .data!.docs[index]["rating"]
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
                                        padding:
                                         EdgeInsets.only(right: 10.w, top: 5.h),
                                        child: SizedBox(
                                          width: 151.70.w,
                                          child: Text(
                                              snapshot.data!.docs[index]["coursename"]
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
                                        padding:
                                         EdgeInsets.only(left: 8.w, top: 6.h),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person,),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]["tutter"]
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
                                        padding:
                                         EdgeInsets.only(left: 8.w,),
                                        child: Text(
                                          " \$ ${snapshot.data!.docs[index]["fee"].toString()}",
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
                          }else {
                            return SizedBox();
                          }

                        },
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
              ]),
        )
      ),
    );
  }
}
