import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/Bottam_Navigationbar.dart';
import 'package:learning/Home.dart';
import 'package:learning/Phonenumber.dart';
import 'package:learning/login.dart';
import 'package:learning/reset_Password_email.dart';
import 'package:learning/rest_password.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 75.h,),
              Center(
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle:
                        TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w900)),
                  )),
              SizedBox(height:40.h,),
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text(
                  'Full Name',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: 7.h,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextField(decoration: InputDecoration(hintText: "Name",border: OutlineInputBorder())),
              ),
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(right: 285),
                child: Text(
                  "Email",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: 7.h,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextField(decoration: InputDecoration(hintText: "email",border: OutlineInputBorder())),
              ),
          
              SizedBox(height: 15.h,),
              Padding(
                padding: const EdgeInsets.only(right: 248),
                child: Text(
                  'Password',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: 7.h,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextField(decoration: InputDecoration(hintText: "*************",border: OutlineInputBorder())),
          
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: const EdgeInsets.only(right: 180),
                child: Text(
                   'Confirm Password',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(height: 7.h,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextField(decoration: InputDecoration(hintText: "*************",border: OutlineInputBorder())),
          
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220,top: 12),
                child: GestureDetector(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ResetPassword()));
                  },
                  child: Text(
                      'Forget Password?',
                      style:GoogleFonts.plusJakartaSans(textStyle:TextStyle(
                        color: Color(0xFFF8C657),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: 0.24,
                      ),)
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
          
              GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BottamNavigation()));},
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
                      'Sign Up',
                      style: GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.36,)
                      ),
                    ),
                  ),
                ),
              ), SizedBox(height: 20.h,),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Row(
                  children: [
                    SizedBox(width: 130.w,
                        child: Divider(thickness: 1,color: Colors.black,)),
                    SizedBox(width: 5.w,),
                    Text(
                        'Or Sign In With',
                        style:  GoogleFonts.plusJakartaSans(textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.26,
                        ),)
                    ),
                    SizedBox(width: 5.w,),
                    SizedBox(width: 130.w,
                        child: Divider(thickness: 1,color: Colors.black,)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100,top: 20),
                child: Row(
                  children: [
                    GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Phonenumber()));},
                      child: Container(
                        width: 80.h,
                        height: 46.w,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(side: BorderSide(width: 1.w,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),child: Icon(Icons.call,color: Colors.green,),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Container(
                      width: 80.h,
                      height: 46.w,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(side: BorderSide(width: 1.w,color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),child: Image.asset("assets/Google.png"),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80,top: 20),
                child: Row(
                  children: [
                    Text(
                        'Already have an account?',
                        style:  GoogleFonts.plusJakartaSans(textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.26,
                        ),)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Login()));},
                        child: Text(
                            'Login Here',
                            style:  GoogleFonts.plusJakartaSans(textStyle: TextStyle(
                              color: Color(0xFFF8C657),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: 0.26,
                            ),)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
