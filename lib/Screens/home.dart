import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/bookdetail.dart';
import 'package:growbymargin/Screens/morebook.dart';
import 'package:growbymargin/Screens/onboard.dart';
import 'package:growbymargin/helper/authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationHelper authenticationHelper = AuthenticationHelper();
  int index = 0;

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
    final db=FirebaseFirestore.instance;
    //final List<String> id=List.generate(length, (index) => null)
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        elevation: 0.0,
        leading: Container(
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
                authenticationHelper.signOut();
              },
              icon: Icon(
                Icons.dashboard,
                color: Colors.black54,
                size: 8.w,
              )),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
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
      body: SlidingUpPanel(
          //defaultPanelState: PanelState.CLOSED,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Color(0xff4DB6AC),
          maxHeight: MediaQuery.of(context).size.height * 0.35,
          minHeight: 80,
          body: Container(
            color: Colors.white,
            //height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 2.w,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black45,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  hintStyle: GoogleFonts.firaSans(
                                      textStyle:
                                          TextStyle(color: Colors.black26))),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.mic),
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('BookCollection').snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(color: Colors.teal[300],),
                          );
                        }else {
                          //print(snapshot.data!.docs.toList()[0].id.toString());
                          return Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GridView(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1/1.7,
                                crossAxisCount: 2,
                                //crossAxisSpacing: 20,
                                //mainAxisSpacing: 10
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: snapshot.data!.docs.map((doc){
                                return Container(
                                  child: GridTile(
                                    imageUrl: doc['bookCoverImageUrl'],
                                    name: doc['bookName'],
                                    writer: 'Morgan Housel',
                                    id: doc.id.toString(),
                                    mrp: doc['bookMrp'],
                                    desc: doc['bookDescription'],
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
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                              'Books on Ayurvedic Herbs',
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('BookCollection').where('bookCollectionName',isEqualTo: 'Ayurvedic Herbs').snapshots(),
                      builder: (context,snapshot){
                        if (!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(color:Colors.teal[300]),
                          );
                        }else
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.33,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              shrinkWrap: true,
                              //physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((doc){
                                return Container(
                                  child: BookTile(
                                        imageUrl: doc['bookCoverImageUrl'],
                                        name: doc['bookName'],
                                        writer: 'Morgan Housel',
                                      ),
                                );
                              }).toList(),
                            ),
                          );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                              'Books on Herbal Products',
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
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('BookCollection').where('bookCollectionName',isEqualTo: 'Herbal Products').snapshots(),
                      builder: (context,snapshot){
                        if (!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(color:Colors.teal[300]),
                          );
                        }else
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.33,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              shrinkWrap: true,
                              //physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((doc){
                                return Container(
                                  child: BookTile(
                                        imageUrl: doc['bookCoverImageUrl'],
                                        name: doc['bookName'],
                                        writer: 'Morgan Housel',
                                      ),
                                );
                              }).toList(),
                            ),
                          );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                              'Books on Phytotherapy',
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
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('BookCollection').where('bookCollectionName',isEqualTo: 'Phytotherapy').snapshots(),
                      builder: (context,snapshot){
                        if (!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(color:Colors.teal[300]),
                          );
                        }else
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.33,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              shrinkWrap: true,
                              //physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((doc){
                                return Container(
                                  child: BookTile(
                                        imageUrl: doc['bookCoverImageUrl'],
                                        name: doc['bookName'],
                                        writer: 'Morgan Housel',
                                      ),
                                );
                              }).toList(),
                            ),
                          );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                              'Books on Homeopathy',
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
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('BookCollection').where('bookCollectionName',isEqualTo: 'Homeopathy').snapshots(),
                      builder: (context,snapshot){
                        if (!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(color:Colors.teal[300]),
                          );
                        }else
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.33,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              shrinkWrap: true,
                              //physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((doc){
                                return Container(
                                  child: BookTile(
                                        imageUrl: doc['bookCoverImageUrl'],
                                        name: doc['bookName'],
                                        writer: 'Morgan Housel',
                                      ),
                                );
                              }).toList(),
                            ),
                          );
                      },
                    ),
                  ),*/
                  SizedBox(
                    height: 226,
                  )
                ],
              ),
            ),
          ),
          panel: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.drag_handle,
                color: Colors.black26,
                size: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Continue Reading',
                          style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 30,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://source.unsplash.com/aZ_MmSmAcjg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.31,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    'The Psychology of Money',
                                    style: GoogleFonts.prompt(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Text(
                                    'By Morgan Housel',
                                    style: GoogleFonts.prompt(
                                        textStyle: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                    size: 19,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                    size: 19,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                    size: 19,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                    size: 19,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.black26,
                                    size: 19,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(2, 10, 5, 10),
                      height: MediaQuery.of(context).size.width * 0.20,
                      width: MediaQuery.of(context).size.width * 0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //image: DecorationImage(image: NetworkImage('https://source.unsplash.com/aZ_MmSmAcjg'),fit: BoxFit.cover)
                      ),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: 0.65,
                        center: new Text("65%"),
                        progressColor: Colors.red[400],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal[300],
          selectedFontSize: 13,
          unselectedFontSize: 13,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.explore)),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MoreBook()));
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Icon(Icons.book_outlined)),
                label: "Reading"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    child: Icon(Icons.bookmark_outline)),
                label: "Bookmark")
          ],
        ),
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  final String name, imageUrl, writer;
  BookTile({required this.imageUrl, required this.name, required this.writer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
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
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'By $writer',
                style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                overflow: TextOverflow.ellipsis,
              )
            ),
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
              )
            ),
          ],
        ),
      ),
    );
  }
}

class GridTile extends StatelessWidget {
  final String name, imageUrl, writer,id,mrp,desc;
  GridTile({required this.imageUrl, required this.name, required this.writer,required this.id, required this.mrp, required this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context)=>DetailBook(
              bookID: id,
              imgUrl: imageUrl,
              author: writer,
              bname: name,
              bMrp: mrp,
              bdesc: desc,
            )
          )
        );
      },
      child: Container(
        //color: Colors.pink,
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              height: MediaQuery.of(context).size.height * 0.30,
              //width: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
            Container(
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
              )
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '$name',
                style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                overflow: TextOverflow.ellipsis,
              )
            ),
          ],
        ),
      ),
    );
  }
}