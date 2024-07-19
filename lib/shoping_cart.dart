import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/video.dart';

class ShopingCart extends StatefulWidget {
  const ShopingCart({super.key});

  @override
  State<ShopingCart> createState() => _ShopingCartState();
}

class _ShopingCartState extends State<ShopingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title:
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(
            child: Text("Cart",
              style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,)
              ),),
          ),
        ),
        leading: IconButton(
            onPressed: () {  Navigator.of(context).pop();},
            icon:  Icon(Icons.arrow_back_ios_new_rounded,color: Color(0xFF477B72),),
            ),
      ),
      body: Column(children: [
        SizedBox(width: 500.w,height:750.h,
          child: ListView.separated(
            itemCount: 2,scrollDirection: Axis.vertical,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Video()));},
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
                            child: Column(
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
                                  padding: const EdgeInsets.only(right: 30,top: 5),
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
                                Opacity(
                                  opacity: 0.50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 40,top: 5),
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
                                          itemSize: 17,
                                          initialRating: 4,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 90,top: 5),
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
                height: 15.h,
              );
            },

          ),

        ),
      ],),
    );
  }
}
