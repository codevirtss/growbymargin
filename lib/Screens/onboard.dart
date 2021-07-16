import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({ Key? key }) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: 100.w,
            height: 100.h,
            child: Image.asset('assets/Images/image1.jpg',fit: BoxFit.cover,),
          ),
          Container(
            width: 100.w,
            height: 75.h,
            margin: EdgeInsets.fromLTRB(7.w, 25.h, 7.w, 5.h),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: 40.w,
                  height: 40.w,
                  padding:EdgeInsets.all(2.w),
                  child: CircleAvatar(
                    child: Image.network('https://source.unsplash.com/80hj671r_2g')
                  ),
                ),
                Center(
                  child: Text('Tandur',
                    style: GoogleFonts.kanit(textStyle: TextStyle(fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,fontSize: 19.sp)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Text('Plant a ',
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 26.sp)),
                          ),
                          Text('tree',
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 26.sp,color: Color(0xff92E3A9))),
                          ),
                          Text(',',
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 26.sp)),
                          ),
                        ]
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Text('green',
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 26.sp,color: Color(0xff92E3A9))),
                          ),
                          Text(' the earth',
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 26.sp)),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100.h,
                  height: 6.h,
                  margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 12.h,bottom: 3.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                  child: MaterialButton(
                    onPressed: (){},
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
                    color: Color(0xff92E3A9),
                    child: Text('Sign In',
                      style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.white)),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text('Create an Account',
                    style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w500,color: Colors.black38,wordSpacing: 0.5.w,letterSpacing: 0.5.sp)),
                  ),
                  onTap: (){},

                )
              ],
            ),
          ),
        ],
      ),      
    );
  }
}