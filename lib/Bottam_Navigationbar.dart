import 'package:flutter/material.dart';
import 'package:learning/Home.dart';
import 'package:learning/Profile.dart';
import 'package:learning/favourites.dart';
import 'package:learning/chat_list.dart';
import 'package:learning/Search.dart';
import 'package:learning/saved.dart';

class BottamNavigation extends StatefulWidget {
  const BottamNavigation({super.key});

  @override
  State<BottamNavigation> createState() => _BottamNavigationState();
}

class _BottamNavigationState extends State<BottamNavigation> {
  final screens = [Home(),Save(),Search(),Chat(),Profile(),];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(showSelectedLabels: false,
        backgroundColor: Colors.yellow,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Color(0xFFF6C354) : Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark,
                  color: currentIndex == 1 ? Color(0xFFF6C354) : Colors.black),
              label: "notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: currentIndex == 2 ? Color(0xFFF6C354) : Colors.black),
              label: "cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline,
                  color: currentIndex == 3 ? Color(0xFFF6C354) : Colors.black),
              label: "account"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: currentIndex == 4 ? Color(0xFFF6C354) : Colors.black),
              label: "account")
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
