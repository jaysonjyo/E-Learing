import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/chat.dart';
import 'package:learning/ebooks.dart';
import 'package:learning/editprofile.dart';
import 'package:learning/login.dart';
import 'package:learning/shoping_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  final firestoreprofile =
      FirebaseFirestore.instance.collection("users").snapshots();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExitWidget(

      snackBarMessage: 'Press back again to exit',
      child:  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding:  EdgeInsets.only(left: 50.w),
            child: Center(
              child: Text(
                "Profile",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                  color: Color(0xFF1D1B20),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.24.w,
                )),
              ),
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
                  size: 29.sp,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreprofile,
              builder:
                  (BuildContext position, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]["id"].toString() ==
                        auth.currentUser!.uid.toString()) {
                      index = i;
                    }
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50.r,backgroundImage:NetworkImage(snapshot.data!.docs[index]["profile"].toString()),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 60, left: 65),
                            //   child: Icon(
                            //     Icons.add_a_photo,
                            //     color: Colors.green,
                            //     size: 30,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        snapshot.data!.docs[index]["name"].toString(),
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                          color: Color(0xFF202244),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      Text(
                        auth.currentUser!.email.toString(),
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                          color: Color(0xFF545454),
                          fontSize: 13.sp,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      GestureDetector(onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Editprofile(index:index,)));
                      },
                        child: Container(
                          width: 341.w,
                          height: 49.h,
                          padding:  EdgeInsets.all(10.sp),
                          decoration: ShapeDecoration(
                            color: Color(0xFFC6D6D3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 80.w),
                                  child: SizedBox(
                                    width: 150.w,
                                    height: 20.h,
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp)),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                   Icon(
                                      Icons.keyboard_double_arrow_right_outlined),
                                  // onPressed: () {
                                  //
                                  // },
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 341.w,
                        height: 49.h,
                        padding:  EdgeInsets.all(10.r),
                        decoration: ShapeDecoration(
                          color: Color(0xFFC6D6D3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.key,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 80.w),
                                child: SizedBox(
                                  width: 150.w,
                                  height: 20.h,
                                  child: Text(
                                    "Account",
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp)),
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_double_arrow_right_outlined)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Chat()));
                      },
                        child: Container(
                          width: 341.w,
                          height: 49.h,
                          padding:  EdgeInsets.all(10.sp),
                          decoration: ShapeDecoration(
                            color: Color(0xFFC6D6D3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.help_outline_outlined,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 80.w),
                                  child: SizedBox(
                                    width: 150.w,
                                    height: 20.h,
                                    child: Text(
                                      "Help",
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp)),
                                    ),
                                  ),
                                ),
                                Icon(Icons.keyboard_double_arrow_right_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 341.w,
                        height: 49.h,
                        padding:  EdgeInsets.all(10.sp),
                        decoration: ShapeDecoration(
                          color: Color(0xFFC6D6D3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r)),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 80.w),
                                child: SizedBox(
                                  width: 150.w,
                                  height: 20.h,
                                  child: Text(
                                    "About Us",
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp)),
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_double_arrow_right_outlined)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(onTap: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> Login()), (route)=>false);

                      },
                        child: Container(
                          width: 341.w,
                          height: 49.h,
                          padding:  EdgeInsets.all(10.sp),
                          decoration: ShapeDecoration(
                            color: Color(0xFFC6D6D3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: 80.w),
                                  child: SizedBox(
                                    width: 150.w,
                                    height: 20.h,
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp)),
                                    ),
                                  ),
                                ),
                                Icon(Icons.keyboard_double_arrow_right_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
