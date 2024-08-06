import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatefulWidget {
  final String Verification;
  const OTP({super.key, required this.Verification});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 250.h),
              child: OtpTextField(
                borderRadius: BorderRadius.circular(10.r),
                borderWidth: 1.w,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                numberOfFields: 6,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  final credentials = PhoneAuthProvider.credential(
                      verificationId: widget.Verification,
                      smsCode: verificationCode);

                  try{

                    await auth.signInWithCredential(credentials);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Home()));
                    CheckLogin();
                  }catch(error){
                    Fluttertoast.showToast(msg: "error");
                  }


                }, // end onSubmit
              ),
            ),
          ],
        ),
      ),
    );;
  }

  void CheckLogin ()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Token", true);
  }

}
