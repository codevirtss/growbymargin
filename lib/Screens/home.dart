import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/bookdetail.dart';
import 'package:growbymargin/Screens/bottomNavBar.dart';
import 'package:growbymargin/Screens/cart.dart';
import 'package:growbymargin/Screens/offerBookDetailed.dart';
import 'package:growbymargin/Screens/onboard.dart';
import 'package:growbymargin/Screens/sidebar.dart';
import 'package:growbymargin/helper/authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationHelper authenticationHelper = AuthenticationHelper();

  bool isLoggedIn = false;

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

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    //final List<String> id=List.generate(length, (index) => null)
    return Scaffold(
        backgroundColor: Colors.grey[50],
        drawer: TheDrawer(),
        appBar: AppBar(
          elevation: 0.0,
          leading: Builder(
            builder: (context) => Container(
              width: 56,
              height: 56,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 3.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.1))
                  ]),
              child: IconButton(
                  onPressed: () {
                    //authenticationHelper.signOut();
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black54,
                    size: 8.w,
                  )),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                child: Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.1))
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                  ),
                ),
              ),
              isLoggedIn == true
                  ? Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 5, bottom: 5, left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.1),
                          ),
                        ],
                      ),
                      child: ClipOval(
                          child: Image.network(
                        'https://source.unsplash.com/cIEb4UJ4ruk',
                        fit: BoxFit.contain,
                      )),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: OnBoard(),
                                type: PageTransitionType.leftToRight));
                      },
                      child: Text("Login")),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          //height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  //color: Colors.pink,
                  width: 100.w,
                  height: 20.h,
                  margin: EdgeInsets.only(
                    bottom: 8,
                    top: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('Offers').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal[300],
                            ),
                          );
                        } else
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp)),
                                width: 100.w,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      height: 100.h,
                                      enlargeCenterPage: false,
                                      autoPlay: true,
                                      aspectRatio: 16 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      // autoPlayAnimationDuration: Duration(microseconds: 10),
                                      viewportFraction: 1.0),
                                  items: snapshot.data!.docs.map((doc) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (doc['type'] == 'UrlOffer') {
                                          if (await canLaunch(
                                              '${doc['destinationUrl']}')) {
                                            await launch(
                                              doc['destinationUrl'],
                                            );
                                          }
                                        } else if (doc['type'] == 'BookOffer') {
                                          print("${doc["bookId"]}");
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: OfferBookDetails(
                                                      bookId: doc["bookId"]),
                                                  type: PageTransitionType
                                                      .leftToRight));
                                        }
                                      },
                                      child: Container(
                                        //margin: EdgeInsets.symmetric(vertical: 7.h,horizontal: 6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.0, 0.1))
                                            ],
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${doc['imageUrl']}'),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.grey,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          );
                      },
                    ),
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.sp)),
                ),
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection('BookCollection').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal[300],
                          ),
                        );
                      } else {
                        //print(snapshot.data!.docs.toList()[0].id.toString());
                        return Container(
                          width: 100.w,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 1.5,
                              crossAxisCount: 2,
                              //crossAxisSpacing: 20,
                              //mainAxisSpacing: 10
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs.map((doc) {
                              return Container(
                                child: GridTile(
                                  imageUrl: doc['bookCoverImageUrl'],
                                  name: doc['bookName'],
                                  writer: 'Morgan Housel',
                                  id: doc.id.toString(),
                                  mrp: doc['bookMrp'],
                                  desc: doc['bookDescription'],
                                  price: doc['bookPrice'],
                                  collection: doc['bookCollectionName'],
                                  bookPreviewUrl: doc['bookPreviewUrl'],
                                  //bookID: doc['bookID'],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
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
        bottomNavigationBar: BottomNav(
          index: 0,
        ));
  }
}

class GridTile extends StatelessWidget {
  final String name,
      imageUrl,
      writer,
      id,
      mrp,
      desc,
      price,
      collection,
      bookPreviewUrl;
  GridTile(
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
        Navigator.push(
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
        height: 40.h,
        //color: Colors.pink,
        //  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              height: MediaQuery.of(context).size.height * 0.25,
              //width: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
            /*Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  'By $writer',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.7.sp,
                          fontWeight: FontWeight.w600)),
                  overflow: TextOverflow.ellipsis,
                )),*/
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '$name',
                  style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
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
