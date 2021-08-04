import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/cart.dart';
import 'package:growbymargin/Screens/profile.dart';
import 'package:growbymargin/Screens/purchase.dart';
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
                Scaffold.of(context).openEndDrawer();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
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
                Scaffold.of(context).openEndDrawer();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
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
                //authenticationHelper.signOut();
                Scaffold.of(context).openEndDrawer();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase()));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.library_books,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('Purchases',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,height: 0,),
            ListTile(
              onTap: (){
                //authenticationHelper.signOut();
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.support_agent,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('Support',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,height: 0,),
            ListTile(
              onTap: (){
                //authenticationHelper.signOut();
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.info_outline_rounded,size: 16.sp,),
                    SizedBox(width: 10,),
                    Text('About',style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp)),)
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