import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override

  Widget build(BuildContext context) {
    TextEditingController chattext=TextEditingController();
    FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .collection("chat");
    final firestoreSub = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .collection("chat")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF477B72),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.r,backgroundImage: AssetImage("assets/helpcenter.png",),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Help Center',
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                  stream: firestoreSub,
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.hasError){
                      return Center(child: Text("Error"),);
                    }
                    if(snapshot.hasData){
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                              //chater
                                ChatBubble(
                                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 20),
                                  backGroundColor: Colors.blue,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Text(
                                     snapshot.data!.docs[position]["message"].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            //function
                            snapshot.data!.docs[position]["respones"].toString()==""?SizedBox():
                                //function
                            ChatBubble(
                              clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor: Colors.red,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Text(
                                  snapshot.data!.docs[position]["respones"].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            // if(snapshot.data!.docs[position]["respones"] !="")
                            // //respones
                            // ChatBubble(
                            //   clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                            //   alignment: Alignment.topLeft,
                            //   margin: EdgeInsets.only(top: 20),
                            //   backGroundColor: Colors.grey,
                            //   child: Container(
                            //     constraints: BoxConstraints(
                            //       maxWidth: MediaQuery.of(context).size.width * 0.7,
                            //     ),
                            //     child: Text(
                            //       snapshot.data!.docs[position]["respones"].toString(),
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            // )

                          ],
                        );
                      },
                      separatorBuilder: (context, position) {
                        return SizedBox(
                        );
                      },

                    );


                    }else{
                      return SizedBox();
                    }
                  }
                ),
          ),
          SizedBox(height: 80.h,)
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
        child: TextField(
          controller: chattext,
          decoration: InputDecoration(
              hintText: "Type message..",
              prefixIcon: Icon(Icons.insert_emoticon_outlined),
              suffixIcon: IconButton(onPressed: (){
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                firestore.doc(id).set({
                  "id":id,
                  "message":chattext.text.toString(),
                  "respones":"",
                }).then((onValue){
                  chattext.clear();
                });
              },
                icon: Icon(
                  Icons.send,
                ),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),

    );
  }
}
