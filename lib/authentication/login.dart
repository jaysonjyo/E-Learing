import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning/Bottam_Navigationbar.dart';
import 'package:learning/Home_pages/Home.dart';
import 'package:learning/authentication/Phonenumber.dart';
import 'package:learning/authentication/Signup.dart';
import 'package:learning/authentication/reset_Password_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isVisible=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key:_formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Center(
                    child: Text(
                  "Login",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: 38.sp, fontWeight: FontWeight.w900)),
                )),
                SizedBox(
                  height: 120.h,
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
                      validator: (value){
                if (value!.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                return 'Enter a valid email!';
                }
                return null;
                }
                  ),
                ),
                SizedBox(
                  height: 50.h,
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
                          hintText: "*************",suffixIcon: InkWell(child: Icon(Icons.visibility),onTap: (){
                            setState(() {
                              isVisible=! isVisible;
                            });
                      },),
                          border: OutlineInputBorder()),
                    validator: (value){
                    if (value!.isEmpty || value.length<6) {
                      return 'Enter a valid password!....';
                    }
                    return null;
                  },
            
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 220.w, top: 12.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Emailreset()));
                    },
                    child: Text('Forget Password?',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                            color: Color(0xFFF8C657),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.24.w,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                GestureDetector(
                  onTap: () async {
                    print("hello");
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      await  auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((Value){
                      CheckLogin();
                        Fluttertoast.showToast(msg: ' Successfully Login');
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => BottamNavigation()));
                      }).onError((error, StackTrace){  Fluttertoast.showToast(msg: error.toString());});
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
                        'LOGIN',
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
                      GestureDetector(onTap: (){
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
                      Text('Don’t have an account?',
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
                                MaterialPageRoute(builder: (_) => Signup()));
                          },
                          child: Text('Sign Up Here',
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
        firestore.doc(auth.currentUser!.uid.toString()).set({
          "name": auth.currentUser!.displayName.toString(),
          "id": auth.currentUser!.uid.toString(),
          "email":auth.currentUser!.email.toString(),
          "security": "",
          "profile":auth.currentUser!.photoURL.toString(),
          "premium":false
        });
        Fluttertoast.showToast(msg: "Success");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => BottamNavigation()),(route)=>false);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
  void CheckLogin ()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Token", true);
  }





}
