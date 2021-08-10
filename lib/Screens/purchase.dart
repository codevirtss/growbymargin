import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/PdfViewer/pdfViewr.dart';
import 'package:growbymargin/Screens/feedback_form.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:growbymargin/Utils/GlobalVariables.dart';
import 'package:growbymargin/helper/PurchaseHelper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

num sum = 0;

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  // Future<File> createFileOfPdfUrl() async {
  //   Completer<File> completer = Completer();
  //   print("Start download file from internet!");
  //   try {
  //     // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
  //     // final url = "https://pdfkit.org/docs/guide.pdf";
  //     final url = "http://www.pdf995.com/samples/pdf.pdf";
  //     final filename = url.substring(url.lastIndexOf("/") + 1);
  //     var request = await HttpClient().getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     var bytes = await consolidateHttpClientResponseBytes(response);
  //     var dir = await getApplicationDocumentsDirectory();
  //     print("Download files");
  //     print("${dir.path}/$filename");
  //     File file = File("${dir.path}/$filename");

  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

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
                      .collection('Cart')
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
                                          fullURl:
                                              'https://firebasestorage.googleapis.com/v0/b/growapp-19c06.appspot.com/o/Books%2Fab16d5d7-9a83-4bb6-81ea-3662e2a95c53%2FFull?alt=media&token=75aab7ab-71c1-45e6-8c33-4eaf4fa6f564',
                                        ));
                                      }).toList()),
                                  /*Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.1))],
                                      color: Colors.white,
                                    ),
                                    width: 100.w,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        padding: EdgeInsets.only(left: 10,right: 5,top: 5,bottom: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              'Total: $sum',
                                              style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            onPressed: () {},
                                            color: Colors.orange[800],
                                            height: 45,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Text(
                                              'Checkout',
                                              style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
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
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                          color: Colors.orange[800],
                          borderRadius: BorderRadius.circular(8)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedbackForm(
                                          bookID: id,
                                        )));
                          },
                          icon: Icon(
                            Icons.feedback,
                            color: Colors.white,
                          )),
                    ),
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
