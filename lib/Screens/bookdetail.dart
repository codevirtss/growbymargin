import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailBook extends StatefulWidget {
  final String bookID, imgUrl, bname, author, bMrp, bdesc, price,collName;
  DetailBook({
    required this.bookID,
    required this.imgUrl,
    required this.bname,
    required this.author,
    required this.bMrp,
    required this.bdesc,
    required this.price,
    required this.collName,
  });

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  final db = FirebaseFirestore.instance;

  int index = 0;
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
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.teal[300], shape: BoxShape.circle),
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                      )
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
                      stream: db.collection('BookCollection').where('bookCollectionName',isEqualTo: widget.collName).snapshots(),
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
                                        id: doc.id.toString(),
                                        mrp: doc['bookMrp'],
                                        desc: doc['bookDescription'],
                                        price: doc['bookPrice'], 
                                        collection: doc['bookCollectionName'],
                                      ),
                                );
                              }).toList(),
                            ),
                          );
                      },
                    ),
                  ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 30),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30, right: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 55,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' QTY ',
                    style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  VerticalDivider(
                    color: Colors.black38,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count > 0 ? count -= 1 : count = 0;
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black54,
                      size: 19,
                    ),
                  ),
                  Text(
                    '${count.toString()}',
                    style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count += 1;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black54,
                      size: 19,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              elevation: 0,
              height: 55,
              padding: EdgeInsets.only(left: 8, right: 8),
              color: Colors.orange[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              onPressed: () {},
              child: Text(
                'Add to Cart',
                style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BookTile extends StatelessWidget {
  final String name, imageUrl, writer, id, mrp, desc, price,collection;
  BookTile(
      {required this.imageUrl,
      required this.name,
      required this.writer,
      required this.id,
      required this.mrp,
      required this.desc,
      required this.price, 
      required this.collection});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
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
                    collName: collection,)));
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
                )),
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
          ],
        ),
      ),
    );
  }
}
