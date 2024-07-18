import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text("Welcome",
              style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
              color: Color(0xFF1D1B20),
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.24,)
                  ),),
            Text('Khan',
              style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF477B72),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,)
              ),),
          ],
          
        ),
      actions: [Padding(
        padding: const EdgeInsets.only(right:20),
        child: Icon(Icons.shopping_cart_outlined,size: 29,),
      )],),body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 15,top: 20),
        child: Row(
          children: [
            Text(
              'Categories',
              style: GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.18,)
              ),
            ),
            SizedBox(width: 210.w,),
            Text(
              'See All',
              style: GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.18,)
              ),
            ),



          ],
        ),
      ),
      SizedBox(height: 20.h,)
,      SizedBox(width: 500..w,height: 250.h,
        child: ListView.separated(
          itemCount: 20,scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return Container(
              width: 195.w,height: 500.h,decoration:
              ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
              child:Column(
                children: [
                  Image.asset('assets/f.png',fit: BoxFit.cover,),
                  Opacity(
                    opacity: 0.50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10),
                      child: Row(
                        children: [
                          Text(
                            '4.5',
                            style: TextStyle(
                              color: Color(0xFF060302),
                              fontSize: 20.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0.10,
                            ),
                          ),
                                        RatingBar.builder(
                      itemSize: 20,
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                  ),Padding(
                    padding: const EdgeInsets.only(right: 20,top: 10),
                    child: SizedBox(
                      width: 151.70,
                      child: Text(
                        'UI/UX Design',
                        style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(
                          color: Color(0xFF060302),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 6),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 5.w,),
                        Text(
                          'Stephen Moris',
                          style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                            color: Color(0xFF060302),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.14,)
                          ),
                        )
                      ],
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(right: 110,top: 5),
                    child: Text(
                      '\$14.50',
                      style: GoogleFonts.plusJakartaSans(textStyle:TextStyle(
                        color: Color(0xFF477B72),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.18,)
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
          separatorBuilder: (context, position) {
            return SizedBox(
             width: 20.w,
            );
          },

        ),
      ),



    ],),

    );
  }
}
