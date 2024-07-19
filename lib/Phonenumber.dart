import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/Phone_otp.dart';

class Phonenumber extends StatefulWidget {
  const Phonenumber({super.key});

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only( top: 150),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  decoration: InputDecoration(focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      ),
                      hintText: "Phone Number",prefix: Text("+91"),
                      enabledBorder: OutlineInputBorder(
                         )
                  ),
                ),
              ),
              SizedBox(height: 190.h,),
              GestureDetector(onTap: () async {
Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OTP()));

              },
                child: Container(
                  width: 280.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              width: 0.10.w, color: Colors.black12))),
                  child: Center(
                    child: Text(
                      "Send OTP",
                      style: GoogleFonts.jost(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
