import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/PdfViewer/pdfViewr.dart';
import 'package:growbymargin/Screens/feedback_form.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:growbymargin/helper/PurchaseHelper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

num sum = 0;

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  _PurchaseState createState() => _PurchaseState(); 
}

class _PurchaseState extends State<Purchase> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical, 
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                //width: MediaQuery.of(context).size.width,
                //color: Colors.white,
                child: StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('Users')
                      .doc(currentUser!.uid)
                      .collection('Books')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text('No Item in Cart'),
                      );
                    } else
                      return snapshot.data!.docs.length != 0
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  ListView(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      children: snapshot.data!.docs.map((doc) {
                                        return Container(
                                            child: BookTile(
                                          name: '${doc['bookName']}',
                                          image: '${doc['imageUrl']}',
                                          price: '${doc['price']}',
                                          mrp: '${doc['mrp']}',
                                          id: '${doc['bookID']}',
                                          fullURl: '${doc['full']}',
                                        ));
                                      }).toList()),
                                ],
                              ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 50.h,
                                    child:
                                        Image.asset("assets/Images/cart.gif")),
                                Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
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
                            );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  final String image, name, price, mrp, id, fullURl;
  BookTile({
    required this.name,
    required this.image,
    required this.price,
    required this.mrp,
    required this.id,
    required this.fullURl,
  });

  @override
  Widget build(BuildContext context) {
    PurchaseHelper purchaseHelper = PurchaseHelper();
    num p = int.parse(price.split(' ').first);
    print("p = $p");
    sum = sum + p;
    return Container(
      width: 100.w,
      height: 50.w,
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.1))],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('Fetch Data and redirect to detail page');
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 35.w,
              height: 45.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.1),
                        spreadRadius: 0.01)
                  ],
                  image: DecorationImage(
                    image: NetworkImage('$image'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Container(
            width: 50.w,
            height: 50.w,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$name',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  )),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '\$${mrp.split(' ')[0]}',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '\$${price.split(' ')[0]}',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Language: ',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      'English',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rating: ',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      '4.1',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: 5),
                    //   width: 11.w,
                    //   height: 11.w,
                    //   decoration: BoxDecoration(
                    //       color: Colors.orange[800],
                    //       borderRadius: BorderRadius.circular(8)),
                    //   child: IconButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => FeedbackForm(
                    //                       bookID: id,
                    //                     )));
                    //       },
                    //       icon: Icon(
                    //         Icons.feedback,
                    //         color: Colors.white,
                    //       )),
                    // ),
                    Expanded(
                        child: Container(
                            //margin: EdgeInsets.only(left: 5,right: 5),
                            height: 11.w,
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: PdfBookOpen(
                                            url: fullURl,
                                            name: name,
                                          ),
                                          type: PageTransitionType.fade));
                                },
                                child: Text("Read",
                                    style: GoogleFonts.prompt(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)))))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
