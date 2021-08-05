import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.teal[300],
                        radius: 20.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.teal[50],
                          radius: 18.9.w,
                          child: CircleAvatar(
                            backgroundColor: Colors.teal[300],
                            radius: 17.4.w,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://source.unsplash.com/cIEb4UJ4ruk'),
                              radius: 17.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal[300],
                              ),
                            );
                          } else
                            return Center(
                              child: Container(
                                child: Column(
                                  children: snapshot.data!.docs.map((doc) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              '${doc['name']}',
                                              style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15.5.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '${doc['email']}',
                                              style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 70,
                                          ),
                                          Container(
                                            //margin: EdgeInsets.symmetric(horizontal: 4),
                                            padding: EdgeInsets.only(
                                                top: 60,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.teal[300],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50))),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 55.h,
                                            child: ListView(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  //margin: EdgeInsets.symmetric(horizontal: 10),
                                                  child: ListTile(
                                                    onTap: () {},
                                                    tileColor: Colors.white,
                                                    horizontalTitleGap: 0,
                                                    leading: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        //color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .orange[800],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.lock,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 50.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      //color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Privacy',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Text(
                                                            'Private differs among cultures.',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        9.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        //color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  child: ListTile(
                                                    onTap: () {},
                                                    tileColor: Colors.white,
                                                    horizontalTitleGap: 0,
                                                    leading: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .orange[800],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.phone,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 50.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Mobile',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Text(
                                                            '9851574008',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  child: ListTile(
                                                    onTap: () {},
                                                    tileColor: Colors.white,
                                                    horizontalTitleGap: 0,
                                                    leading: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .orange[800],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.dashboard,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 50.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'General',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Text(
                                                            'The generic title for all grades.',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        9.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  child: ListTile(
                                                    onTap: () {},
                                                    tileColor: Colors.white,
                                                    horizontalTitleGap: 0,
                                                    leading: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .orange[800],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.settings,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    title: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 50.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Settings',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          Text(
                                                            'Where something is set.',
                                                            style: GoogleFonts.prompt(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        9.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 15.w,
                                                      height: 15.w,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
