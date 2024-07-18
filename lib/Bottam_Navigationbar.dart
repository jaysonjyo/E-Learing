import 'package:flutter/material.dart';
import 'package:learning/Home.dart';
import 'package:learning/Profile.dart';
import 'package:learning/Screen1.dart';
import 'package:learning/Screen3.dart';
import 'package:learning/Scren2.dart';

class BottamNavigation extends StatefulWidget {
  const BottamNavigation({super.key});

  @override
  State<BottamNavigation> createState() => _BottamNavigationState();
}

class _BottamNavigationState extends State<BottamNavigation> {
  final screens = [Home(),Screen2(),Screen1(),Screen3(),Profile(),];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Color(0xFF8204FF) : Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined,
                  color: currentIndex == 1 ? Color(0xFF8204FF) : Colors.black),
              label: "notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings,
                  color: currentIndex == 2 ? Color(0xFF8204FF) : Colors.black),
              label: "cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.email_outlined,
                  color: currentIndex == 3 ? Color(0xFF8204FF) : Colors.black),
              label: "account")
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
