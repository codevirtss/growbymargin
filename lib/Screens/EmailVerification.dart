
import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:growbymargin/Utils/colors.dart';
import 'package:growbymargin/helper/authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  ConstantColors constantColors = ConstantColors();
  AuthenticationHelper authenticationHelper = AuthenticationHelper();

  @override
  void initState() {
    // TODO: implement initState
    var user = FirebaseAuth.instance;
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (authenticationHelper.verifyEmail(context, user)) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: Home(), type: PageTransitionType.rightToLeftWithFade));
        timer.cancel();
      }
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Images/Email.gif"))),
            ),
            Container(
              height: 40.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                  Text(
                      """Email Verifiction Link has been sent to you registerd Email-Id please verify!
                    """,
                  style: TextStyle(fontSize: 20,
                   color: constantColors.blackColor,
                  ),
                      
                    ),
                   Icon(
                      EvaIcons.alertCircleOutline,
                      size: 80,
                      
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
