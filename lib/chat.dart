import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.of(context).pop();},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF477B72),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Jackie',
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.18,
              )),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          BubbleSpecialThree(
            text: 'Added iMessage shape bubbles',
            color: Color(0xFF1B97F3),
            tail: false,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
          BubbleSpecialThree(
            text: 'Please try and give some feedback on it!',
            color: Color(0xFF1B97F3),
            tail: true,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
          BubbleSpecialThree(
            text: 'Sure',
            color: Color(0xFFE8E8EE),
            tail: false,
            isSender: false,
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Type message..",
              prefixIcon: Icon(Icons.insert_emoticon_outlined),suffixIcon: Icon(Icons.send,),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
