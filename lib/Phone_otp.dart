import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: OtpTextField(
                borderRadius: BorderRadius.circular(10.r),
                borderWidth: 1,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                numberOfFields: 6,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {


                }, // end onSubmit
              ),
            ),
            //  SizedBox(height: 250.h,),
            // Container(
            //   width: 200.w,
            //   height: 60.h,
            //   decoration: ShapeDecoration(
            //       color: Colors.black,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20))),
            //   child: Center(
            //     child: Text(
            //       'Continue',
            //       style: GoogleFonts.jost(
            //         textStyle: TextStyle(
            //           color: Colors.white,
            //           fontSize: 22.sp,
            //           fontFamily: 'Jost',
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );;
  }
}
