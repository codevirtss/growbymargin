import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/cart.dart';
import 'package:growbymargin/Screens/onboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:growbymargin/helper/authentication.dart';
import 'package:sizer/sizer.dart';

class DetailBook extends StatefulWidget {
  final String bookID,
      imgUrl,
      bname,
      author,
      bMrp,
      bdesc,
      price,
      collName,
      prev;
  DetailBook({
    required this.bookID,
    required this.imgUrl,
    required this.bname,
    required this.author,
    required this.bMrp,
    required this.bdesc,
    required this.price,
    required this.collName,
    required this.prev,
  });

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  final db = FirebaseFirestore.instance;
  AuthenticationHelper authenticationHelper = AuthenticationHelper();
  int index = 0;

  bool isLoggedIn = false;
  bool isBookAdded = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
  }

  Map<String, dynamic>? paymentIntentData;

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        //leading: GestureDetector(onTap: (){},child: Icon(Icons.arrow_back)),
        title: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(height: 15,),
                    Text(
                      'Detail Book',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Share.share(
                        'Check out this amazing book only on Knowmemore. Download the app now.');
                  },
                  child: Icon(
                    Icons.share,
                    color: Colors.black45,
                  )),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        //height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2.w,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.42,
                padding: EdgeInsets.only(left: 20, right: 20),
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              image: NetworkImage(widget.imgUrl),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '\$${widget.bMrp.split(' ')[0]}',
                                style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '\$${widget.price.split(' ')[0]}',
                                style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          Text(
                            widget.bname,
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            widget.author,
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      isLoggedIn == true
                          ? GestureDetector(
                              onTap: () async {
                                var currentUser =
                                    FirebaseAuth.instance.currentUser;

                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(currentUser!.uid)
                                      .collection('Cart')
                                      .doc(widget.bookID)
                                      .set({
                                    'bookID': widget.bookID,
                                    'bookName': widget.bname,
                                    'price': widget.price,
                                    'mrp': widget.bMrp,
                                    'imageUrl': widget.imgUrl,
                                    'datetime': DateTime.now().toString(),
                                  }).then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Success"),
                                            content: Text("Book added"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                child: Cart(),
                                                                type:
                                                                    PageTransitionType
                                                                        .fade))
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text("Go To Cart"))
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
                                          content: Text("Try after some time"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("OK"))
                                          ],
                                        );
                                      });
                                }
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: OnBoard(),
                                        type: PageTransitionType.leftToRight));
                              },
                              child: Text("Login"))
                    ],
                  )),
              Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Rating',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            '4.1',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black45,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Number of Pages',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            '180',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black45,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Language',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            'English',
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                color: Colors.white,
                child: Text(
                  '${widget.bdesc}',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Colors.orange[800],
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        onPressed: () async {
                          print(widget.prev);
                          EpubViewer.setConfig(
                              identifier: "iosBook",
                              scrollDirection:
                                  EpubScrollDirection.ALLDIRECTIONS,
                              allowSharing: true,
                              enableTts: true,
                              nightMode: true);

                          await EpubViewer.openAsset(
                            'assets/Images/book.epub',
                            lastLocation: EpubLocator.fromJson({
                              "bookId": "2239",
                              "href": "/OEBPS/ch06.xhtml",
                              "created": 1539934158390,
                              "locations": {
                                "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                              }
                            }),
                          );
                          // ge
                        },
                        child: Text(
                          'Preview',
                          style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    isLoggedIn == true
                        ? Expanded(
                            child: MaterialButton(
                              color: Colors.orange[800],
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () async {
                                print("buy...");
                                var finalprice = int.parse(widget.price) * 10;
                                makePayments(widget.price);
                              },
                              child: Text(
                                'Buy',
                                style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          )
                        : Expanded(
                            child: MaterialButton(
                              color: Colors.orange[800],
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: OnBoard(),
                                        type: PageTransitionType.leftToRight));
                              },
                              child: Text(
                                'Login',
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Books on ${widget.collName}',
                          style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        '...',
                        style: GoogleFonts.prompt(
                            textStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 30,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('BookCollection')
                      .where('bookCollectionName', isEqualTo: widget.collName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: Colors.teal[300]),
                      );
                    } else
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        padding: EdgeInsets.only(left: 10),
                        child: ListView(
                          shrinkWrap: true,
                          //physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((doc) {
                            return Container(
                              child: BookTile(
                                imageUrl: doc['bookCoverImageUrl'],
                                name: doc['bookName'],
                                writer: 'Morgan Housel',
                                id: doc.id.toString(),
                                mrp: doc['bookMrp'],
                                desc: doc['bookDescription'],
                                price: doc['bookPrice'],
                                collection: doc['bookCollectionName'],
                                bookPreviewUrl: doc['bookPreviewUrl'],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                  },
                ),
              ),
              SizedBox(
                height: 0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayments(String amount) async {
    final url = Uri.parse(
        'https://us-central1-growapp-19c06.cloudfunctions.net/stripePayment?amount=$amount');

    final response =
        await http.get(
          url, 
          headers: {'Content-Type': 'application/json'});

    paymentIntentData = json.decode(response.body);
    print(paymentIntentData);
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.system,
            merchantCountryCode: 'IND',
            merchantDisplayName: 'Remedies Lifetime'));
    setState(() {});
    displayPaymentsheet();
  }

  Future<void> displayPaymentsheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!["paymentIntent"],
              confirmPayment: true));
      setState(() {
        paymentIntentData = null;
      });
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text("Payment Successfull")));
    } catch (e) {
      print(e);
    }
  }
}

class BookTile extends StatelessWidget {
  final String name,
      imageUrl,
      writer,
      id,
      mrp,
      desc,
      price,
      collection,
      bookPreviewUrl;
  BookTile(
      {required this.imageUrl,
      required this.name,
      required this.writer,
      required this.id,
      required this.mrp,
      required this.desc,
      required this.price,
      required this.collection,
      required this.bookPreviewUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBook(
                      bookID: id,
                      imgUrl: imageUrl,
                      author: writer,
                      bname: name,
                      bMrp: mrp,
                      bdesc: desc,
                      price: price,
                      collName: collection,
                      prev: bookPreviewUrl,
                    )));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.38,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
            /*Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  'By $writer',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                )),*/
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$name',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  overflow: TextOverflow.ellipsis,
                )),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '\$${mrp.split(' ')[0]}',
                          style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
