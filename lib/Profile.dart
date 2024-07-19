import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/shoping_cart.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Center(
            child: Text(
              "Profile",
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,
              )),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ShopingCart()));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 29,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h,),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50.r,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 65),
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.green,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Muhammad Rafey',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
              color: Color(0xFF202244),
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            )),
          ),
          Text(
            'muhammadrafey999@gmail.com',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
              color: Color(0xFF545454),
              fontSize: 13.sp,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
            )),
          ),
          SizedBox(height: 90.h,),
          Container(
            width: 341.w,
            height: 49.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Color(0xFFC6D6D3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              children: [
                SizedBox(width:150.w,height: 20.h,
                  child: Text(
                    "gh",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 139.w,),
                Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 341.w,
            height: 49.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Color(0xFFC6D6D3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              children: [
                SizedBox(width:150.w,height: 20.h,
                  child: Text(
                    "gh",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 139.w,),
                Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 341.w,
            height: 49.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Color(0xFFC6D6D3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              children: [
                SizedBox(width:150.w,height: 20.h,
                  child: Text(
                    "gh",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 139.w,),
                Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 341.w,
            height: 49.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Color(0xFFC6D6D3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              children: [
                SizedBox(width:150.w,height: 20.h,
                  child: Text(
                    "gh",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 139.w,),
                Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 341.w,
            height: 49.h,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Color(0xFFC6D6D3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              children: [
                SizedBox(width:150.w,height: 20.h,
                  child: Text(
                    "gh",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 139.w,),
                Icon(Icons.keyboard_double_arrow_right_outlined)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
