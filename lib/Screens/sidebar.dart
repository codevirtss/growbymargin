import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/helper/authentication.dart';
import 'package:sizer/sizer.dart';


class TheDrawer extends StatefulWidget {

  @override
  TheDrawerState createState() => TheDrawerState();
}

class TheDrawerState extends State<TheDrawer>{
  AuthenticationHelper authenticationHelper = AuthenticationHelper();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  //boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0.0,0.1))]
              ),
              child: CircleAvatar(
                    child: Image.asset('assets/Images/reading.gif')
                  ),
            ),
            ListTile(
              onTap: (){
                //authenticationHelper.signOut();
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.person_outline,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('Profile',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,height: 0,),
            ListTile(
              onTap: (){
                authenticationHelper.signOut();
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.shopping_cart_outlined,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('Cart',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,height: 0,),
            ListTile(
              onTap: (){
                authenticationHelper.signOut();
                Scaffold.of(context).openEndDrawer();
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.logout,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('Logout',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,height: 0,),
          ],
        ),
      ),
    );
  }
  
}