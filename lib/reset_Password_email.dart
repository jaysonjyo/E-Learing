import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Emailreset extends StatefulWidget {
  const Emailreset({super.key});

  @override
  State<Emailreset> createState() => _EmailresetState();
}

class _EmailresetState extends State<Emailreset> {
  TextEditingController email = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(height: 100.h,),
          Center(
              child: Text(
                'Reset Password',
                style: GoogleFonts.plusJakartaSans(
                    textStyle:
                    TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w700)),
              )),
          SizedBox(height: 80.h,),
          Padding(
            padding:  EdgeInsets.only(right: 285.w),
            child: Text(
              "Email",
              style: GoogleFonts.plusJakartaSans(
                  textStyle:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
            ),
          ),
          SizedBox(height: 7.h,),
          Padding(
            padding:  EdgeInsets.only(left: 30.w,right: 30.w),
            child: TextField(
                controller:email,
                decoration: InputDecoration(hintText: "email",border: OutlineInputBorder())),
          ),
          SizedBox(height: 110.h,),
          GestureDetector(onTap: () async {
            await auth.sendPasswordResetEmail(email: email.text).then((
                onValue) {

               Fluttertoast.showToast(msg: "otp send",textColor: Colors.red);
            Navigator.of(context).pop();
            }).onError((error, StackTrace) {Fluttertoast.showToast(msg: "error",textColor: Colors.red);});
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
                  'SUBMIT',
                  style: GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.36.w,)
                  ),
                ),
              ),
            ),
          ), SizedBox(height: 20.h,),
        ],),
      ),
    );
  }
}
