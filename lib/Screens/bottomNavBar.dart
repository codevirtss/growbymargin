import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:growbymargin/Screens/morebook.dart';

class BottomNav extends StatefulWidget {
  int index;
  BottomNav({required this.index});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                  color: Color(0xffeeeeee),
                  offset: Offset(0.1, 0),
                  spreadRadius: 1)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: widget.index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.teal[300],
            selectedFontSize: 13,
            unselectedFontSize: 13,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Icon(Icons.explore)),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreBook()));
                      },
                      child: Icon(Icons.book_outlined)),
                  label: "Reading"),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        
                      },
                      child: Icon(Icons.bookmark_outline)),
                  label: "Bookmark")
            ],
          ),
        ),
      );
  }
}