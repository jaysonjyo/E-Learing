import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/chat.dart';
import 'package:learning/pdfview.dart';
import 'package:learning/shoping_cart.dart';

class Ebook extends StatefulWidget {
  const Ebook({super.key});

  @override
  State<Ebook> createState() => _EbookState();
}

class _EbookState extends State<Ebook> {
  final firestore =FirebaseFirestore.instance.collection("E_Book").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Center(
            child: Text(
              "E-Books",
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                color:Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,
              )),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopingCart()));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,color: Colors.white,
                size: 29,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h,),

          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                return Center(child: Text("Error"),);
              }
              if(snapshot.hasData){
              return SizedBox(
                width: 500.w,
                height: 700.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 300 / 380,
                  shrinkWrap: true,
                  children: List.generate(
                   snapshot.data!.docs.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Pdfview(pdf: snapshot.data!.docs[index]["pdf"].toString())));
                        },
                        child: Container(
                          width: 200.w,
                          height: 500.h,
                          decoration: ShapeDecoration(

                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  width: 200.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        topLeft: Radius.circular(10.r)),
                child: Image.network(snapshot.data!.docs[index]["img"].toString(),fit: BoxFit.cover,),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only( top: 5,left: 9),
                                  child: SizedBox(
                                    width: 151.70,
                                    child: Text(
                                        snapshot.data!.docs[index]["coursename"].toString(),
                                        style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                            color: Color(0xFF060302),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 8),
                                      child:   Text(
                                        snapshot.data!.docs[index]["about"].toString(),
                                          style: TextStyle(
                                            color: Color(0xFF060302),
                                            fontSize: 11.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 1.10,
                                            letterSpacing: 1
                                          ),
                                        ),
                
                
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10),
                                  child: Row(
                                    children: [
                                      Opacity(
                                        opacity: 0.50,
                                        child: Text(snapshot.data!.docs[index]["rating"].toString(),
                                          style: TextStyle(
                                            color: Color(0xFF060302),
                                            fontSize: 20.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0.10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: RatingBar.builder(
                                          itemSize: 16,
                                          initialRating:double.parse(snapshot.data!.docs[index]["rating"].toString()),
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
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart_outlined,color: Colors.black,)),
                                )


                              ],
                            ),
                          ),
                          
                        ),
                      );
                    },
                  ),
                ),
              );}else{
                return SizedBox();
              }
            }
          )
          ],
        ),
      ),
    );
  }
}
