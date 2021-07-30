import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:sizer/sizer.dart';

class BlankCart extends StatefulWidget {
  const BlankCart({ Key? key }) : super(key: key);

  @override
  _BlankCartState createState() => _BlankCartState();
}

class _BlankCartState extends State<BlankCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Icon(Icons.shopping_cart_outlined,color: Colors.black26,size: 200.sp,)),
            Center(
              child: Text(
                'Empty Cart.',
                style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic
                  )
                ),
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                },
                color: Colors.orange[800],
                //height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  'Go to Shop',
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