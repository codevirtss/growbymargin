import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Forget Password",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40.h,
              child: Image.asset(
                "assets/Images/forgetPassword.gif",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 3.w, 10.w, 4.w),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                style: GoogleFonts.roboto(fontSize: 17.sp),
                // obscureText: true,
                decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Enter a valid Email',
                    hintStyle: GoogleFonts.roboto(fontSize: 15.sp),
                    border: UnderlineInputBorder()),
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: () async {
                  if (email.text.isNotEmpty) {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text)
                          .then((value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Success"),
                                content: Text(
                                    "Password reset link has sent on your ${email.text}"),
                                actions: [
                                  TextButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      email.clear();
                                    },
                                  )
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "There is no user recod corresponding to ${email.text}. The user may have been deleted! or never created account on KnowmeMore"),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    email.clear();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Enter a Valid email"),
                          );
                        });
                  }
                },
                color: Colors.orange[800],
                //height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  'Send Password rest Link',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
