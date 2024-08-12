import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Home_pages/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bottam_Navigationbar.dart';

class OTP extends StatefulWidget {
  final String Verification;
  const OTP({super.key, required this.Verification});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final auth =FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");
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

                    await auth.signInWithCredential(credentials).then((onValue) {
                      firestore.doc(auth.currentUser!.uid.toString()).set({
                        "name": "",
                        "id": auth.currentUser!.uid.toString(),
                        "email":"",
                        "security": "",
                        "profile":"",
                        "premium":false
                      });});
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => BottamNavigation()),(route)=>false);
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
