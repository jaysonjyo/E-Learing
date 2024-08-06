import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning/Bottam_Navigationbar.dart';
import 'package:learning/Home.dart';
import 'package:learning/Phonenumber.dart';
import 'package:learning/login.dart';
import 'package:learning/reset_Password_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isVisible = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 75.h,
                ),
                Center(
                    child: Text(
                  "Sign Up",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: 38.sp, fontWeight: FontWeight.w900)),
                )),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 250.w),
                  child: Text(
                    'Full Name',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 30.w, right: 30.w),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        hintText: "Name", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 285.w),
                  child: Text(
                    "Email",
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 30.w, right: 30.w),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "email", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 248.w),
                  child: Text(
                    'Password',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 30.w, right: 30.w),
                  child: TextFormField(
                    controller: password,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                        hintText: "Password...",
                        suffixIcon: InkWell(
                          child: Icon(Icons.visibility),
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password!....';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 180.w),
                  child: Text(
                    'Confirm Password',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 30.w, right: 30.w),
                  child: TextFormField(
                    controller: confirmpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password!';
                      }
                      if (password.text != confirmpassword.text) {
                        return "incorrect password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      await auth
                          .createUserWithEmailAndPassword(
                              email: email.text, password: password.text)
                          .then((Value) {
                        firestore.doc(auth.currentUser!.uid.toString()).set({
                          "name": name.text,
                          "email": email.text,
                          "id": auth.currentUser!.uid.toString(),
                          "security": password.text,
                          "profile":"",
                          'premium':false
                        });
                        Fluttertoast.showToast(msg: 'Successfully registerd');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BottamNavigation()));
                        CheckLogin();
                      }).onError((error, StackTrace) {
                        Fluttertoast.showToast(msg: error.toString());
                      });
                    }
                    _formKey.currentState?.save();
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
                        'Sign Up',
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.36.w,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 13.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 130.w,
                          child: Divider(
                            thickness: 1.sp,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('Or Sign In With',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.26.w,
                            ),
                          )),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                          width: 130.w,
                          child: Divider(
                            thickness: 1.sp,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 100.w, top: 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Phonenumber()));
                        },
                        child: Container(
                          width: 80.h,
                          height: 46.w,
                          padding:  EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.w, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          signInwithGoogle();
                        },
                        child: Container(
                          width: 80.h,
                          height: 46.w,
                          padding:  EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.w, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Image.asset("assets/Google.png"),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 80.w, top: 20.h),
                  child: Row(
                    children: [
                      Text('Already have an account?',
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.26.w,
                            ),
                          )),
                      Padding(
                        padding:  EdgeInsets.only(left: 2.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text('Login Here',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                  color: Color(0xFFF8C657),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.26.w,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> signInwithGoogle() async {
    CheckLogin();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((onValue) {
        Fluttertoast.showToast(msg: "Success");
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  void CheckLogin() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Token", true);
  }
}
