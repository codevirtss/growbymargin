import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/signin.dart';
import 'package:growbymargin/Screens/signup.dart';
import 'package:sizer/sizer.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100.w,
            height: 60.h,
            padding: EdgeInsets.only(top: 10.h),
            child:
                CircleAvatar(child: Image.asset('assets/Images/reading.gif')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              'Manage your team\'s projects',
              style: GoogleFonts.prompt(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.w),
            child: Text(
              'Project management and team work\'s made easy.',
              style: GoogleFonts.prompt(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: Colors.black26)),
            ),
          ),
          Container(
            width: 100.h,
            height: 6.h,
            margin:
                EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 3.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.orange[800],
              child: Text(
                'Get Started',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
