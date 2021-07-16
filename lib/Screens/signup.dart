import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/signin.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController emailId=TextEditingController();
  final TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          width: 100.w,
          height: 100.h,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 75.w,
                height: 75.w,
                child: Image.asset('assets/Images/image2.png',fit: BoxFit.cover,),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 5.w, 10.w, 5.w),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: emailId,
                  style: GoogleFonts.roboto(fontSize: 17.sp),
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.person_outline),
                    hintText:'Name',
                    hintStyle: GoogleFonts.roboto(fontSize: 15.sp),
                    border: UnderlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 3.w, 10.w, 5.w),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailId,
                  style: GoogleFonts.roboto(fontSize: 17.sp),
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.email_outlined),
                    hintText:'Email',
                    hintStyle: GoogleFonts.roboto(fontSize: 15.sp),
                    border: UnderlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 3.w, 10.w, 4.w),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: password,
                  style: GoogleFonts.roboto(fontSize: 17.sp),
                  obscureText: true,
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock_outline),
                    hintText:'Password',
                    hintStyle: GoogleFonts.roboto(fontSize: 15.sp),
                    border: UnderlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 15.w, 10.w, 18.w),
                child: Row(
                  children: [
                    Text('Sign ',
                      style: GoogleFonts.prompt(textStyle: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600,color: Colors.black54,wordSpacing: -0.5.w)),
                    ),
                    Text('Up',
                      style: GoogleFonts.prompt(textStyle: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600,color: Colors.black,)),
                    ),
                    Container(
                      height: 16.w,
                      padding: EdgeInsets.only(left: 27.w),
                      child: MaterialButton(
                        onPressed: (){},
                        child: Icon(Icons.arrow_forward,color: Colors.white,),
                        color: Color(0xff92E3A9),
                        shape: CircleBorder(),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                      },
                      child: Text('Sign In',
                        style: GoogleFonts.prompt(textStyle: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600,color: Colors.black38,decoration: TextDecoration.underline)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w,right: 10.w),
                    child: GestureDetector(
                      onTap: (){},
                      child: Text('Forget Password',
                        style: GoogleFonts.prompt(textStyle: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600,color: Colors.black38,decoration: TextDecoration.underline)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}