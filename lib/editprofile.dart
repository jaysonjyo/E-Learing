import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  final int index;

  const Editprofile({super.key, required this.index});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  File? image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No image Picked");
      }
    });
  }

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users").snapshots();
  final refupdate = FirebaseFirestore.instance.collection("users");
  TextEditingController name = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.24.w,
          )),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Padding(
                              padding:  EdgeInsets.only(top: 50.h),
                              child: Container(
                                width: 130.w,
                                height: 130.h,
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(65.r))),
                                child: ClipOval(
                                  child: image != null
                                      ? Image.file(
                                          image!.absolute,
                                          fit: BoxFit.fill,
                                        )
                                      : Center(child: Icon(Icons.person,size: 50.sp,)),
                                ),
                              )),
                          Padding(
                            padding:  EdgeInsets.only(top: 135.h, left: 75.w),
                            child: IconButton(
                              onPressed: () {
                                getImageGallery();
                              },
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.green,
                                size: 30.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Expanded(
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0.r))),
                                title: Text("Enter your name"),
                                content: TextField(
                                  controller: name,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(

                                      )),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('CANCEL'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      refupdate
                                          .doc(snapshot
                                              .data!.docs[widget.index]["id"]
                                              .toString())
                                          .update({"name": name.text}).then(
                                              (onValue) {
                                        name.clear();
                                        Fluttertoast.showToast(
                                            msg: 'Updated Successfully');
                                        Navigator.of(context).pop();
                                      }).onError((error, stackTrace) {
                                        Fluttertoast.showToast(msg: 'Error');
                                      });
                
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        // TextField(controller: name,autofocus: true,
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter  you name',
                        //   ),
                        // ),
                      },
                      child: Container(
                        width: 500.w,
                        height: 100.h,
                        decoration: ShapeDecoration(
                            color: Colors.black12,
                            shape: RoundedRectangleBorder()),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 10.w),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 60.h),
                                child: Icon(
                                  Icons.person_outlined,
                                  color: Colors.grey,
                                  size: 27.sp,
                                ),
                              ),
                              SizedBox(
                                width: 19.w,
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.24.w,
                                      )),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot
                                              .data!.docs[widget.index]["name"]
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.24.w,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 220.w,
                                        ),
                                        Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "This is not your username or pin. This name will be visible\n this app only",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.24.w,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 55.w),
                      child: Divider(
                        height: 1.h,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),SizedBox(height: 200.h,),
                    GestureDetector(onTap: () async {
                      print("hello");
                      final id = DateTime.now().microsecondsSinceEpoch.toString();
                      Reference ref=storage.ref('/foldername/'+ id);
                      UploadTask uploadtask=ref.putFile(image!.absolute);
                     await Future.value(uploadtask).then((onValue) async{
                       dynamic newurl =await ref.getDownloadURL() ;
                      refupdate.doc(snapshot.data!.docs[widget.index]["id"].toString()).update(
                          {"profile":newurl.toString()}).then((onValue){
                        Fluttertoast.showToast(
                            msg: 'Uploaded');
                Navigator.of(context).pop();
                      }).onError((error, StackTrace){
                        Fluttertoast.showToast(
                            msg: 'error');
                      });
                
                
                
                      });
                
                
                    },
                      child: Container(
                        width: 150.w,
                        height: 50.h,
                        decoration: ShapeDecoration(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))),
                        child:Center(
                          child: Text(
                            "Set your profile",
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.24.w,
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
