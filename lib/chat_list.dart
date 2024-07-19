import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/chat.dart';
import 'package:learning/shoping_cart.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Color color=Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title:
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Center(
            child: Text("Courses",
              style:GoogleFonts.plusJakartaSans(textStyle:  TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.24,)
              ),),
          ),
        ),actions: [Padding(
          padding: const EdgeInsets.only(right:5),
          child:  IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShopingCart()));},
            icon:  Icon(Icons.shopping_cart_outlined,size: 29,),
          ),
        )],
      ),floatingActionButton: FloatingActionButton(
      child: Icon(Icons.message_outlined),
      backgroundColor: Colors.green,
      onPressed: () {
        setState(() {

        });
      },
    ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 60.w,
                  height: 42.h,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC6D6D3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),child: Center(
                  child: Text(
                    'All',
                    style: GoogleFonts.plusJakartaSans(textStyle:   TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
        
                      fontWeight: FontWeight.w700,
        
                      letterSpacing: 0.15,)
                    ),
                  ),
                ),
                ),
                SizedBox(width: 15.w,),
                Container(
                  width: 79.w,
                  height: 42.h,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC6D6D3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),child: Center(
                  child: Text(
                    'Latest',
                    style: GoogleFonts.plusJakartaSans(textStyle:   TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
        
                      fontWeight: FontWeight.w700,
        
                      letterSpacing: 0.15,)
                    ),
                  ),
                ),),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          SizedBox(width: 500.w,height:750.h,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(onTap: (){
                  Navigator.of(context)
.push(MaterialPageRoute(builder: (_)=>Chats())); },
                    title: Text("Shiva",),
                    leading: CircleAvatar(radius: 30.r,),subtitle: Text("hy macha"),


                  ),
                );
              },
              separatorBuilder: (context, position) {
                return SizedBox(
                  height: 8.h,
                );
              },
        
            ),
        
          ),
        ],),
      ),
    );
  }
}
