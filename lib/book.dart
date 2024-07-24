import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/shoping_cart.dart';
import 'package:learning/video.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title:
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Center(
            child: Text("Courses",
              style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,)
              ),),
          ),
        ),actions: [Padding(
          padding: const EdgeInsets.only(right:5),
          child: IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShopingCart()));},
              icon:  Icon(Icons.shopping_cart_outlined,size: 29,),
              ),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                width: 60.w,
                height: 37.h,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Color(0xFFC6D6D3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42.r),
                  ),
                ),child: Center(
                  child: Text(
                    'All',
                    style: GoogleFonts.plusJakartaSans(textStyle:   TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,

                      fontWeight: FontWeight.w700,

                      letterSpacing: 0.15,)
                    ),
                  ),
                ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  width: 115.w,
                  height: 37.h,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC6D6D3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                  ),child: Center(
                    child: Text(
                    'Downloaded',
                    style: GoogleFonts.plusJakartaSans(textStyle:   TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,

                      fontWeight: FontWeight.w700,

                      letterSpacing: 0.15,)
                    ),
                                    ),
                  ),),
              ],
            ),
          ),SizedBox(height: 20.h,),
            SizedBox(width: 500.w,height:750.h,
          child: ListView.separated(
            itemCount: 20,scrollDirection: Axis.vertical,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(onTap: (){
                 // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Video()));
                  },
                  child: Container(
                    width: 180.w,height: 120.h,decoration:
                  ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                    child:Row(
                      children: [
                        Image.asset('assets/f.png',fit: BoxFit.cover,),
                      Padding(
                          padding: const EdgeInsets.only(right: 20,top: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 151.70.w,
                                  child: Text(
                                      'UI/UX Design',
                                      style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(
                                        color: Color(0xFF060302),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8,),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        'Stephen Moris',
                                        style:GoogleFonts.notoSans(textStyle:  TextStyle(
                                          color: Color(0xFF060302),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.14,)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10,right: 38),
                                  child: Text(
                                    'Start your course  ',
                                    style: GoogleFonts.notoSans(textStyle:TextStyle(
                                      color: Color(0xFF060302),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.18,)
                                    ),
                                  ),
                                ),


                              ],
                            ),
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
                height: 10.h,
              );
            },
        
          ),
        
        ),
        
        ],),
      ),
    );
  }
}
