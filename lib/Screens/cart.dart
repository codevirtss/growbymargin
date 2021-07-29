import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Cart extends StatefulWidget {
  const Cart({ Key? key }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final db=FirebaseFirestore.instance;
    var currentUser=FirebaseAuth.instance.currentUser;
    return Scaffold(
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
                        child:
                            Text('No Item in Cart'),
                      );
                    } else
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height * 0.35,
                        //padding: EdgeInsets.only(left: 10),
                        child: ListView(
                          shrinkWrap: true,
                          //physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.docs.map((doc) {
                            return Container(
                              child: CartTile(name: 'Herbal Remedies and Cure All', image: 'https://source.unsplash.com/cIEb4UJ4ruk',price: '100 USD',mrp: '300 USD',)
                            );
                          }).toList(),
                        ),
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

class CartTile extends StatelessWidget {
  final String image,name,price,mrp;
  CartTile({required this.name,required this.image, required this.price, required this.mrp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.w,
      margin: EdgeInsets.only(bottom: 5,top: 5,left: 10,right: 10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0.0,0.1))],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50.w,
            height: 50.w,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$name',
                  style: GoogleFonts.prompt(textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,)),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3,),
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
                SizedBox(height: 3,),
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
                SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pages: ',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      '180',
                      style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(height: 3,),
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
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.zero,
                  height: 35,
                  width: 120,
                  child: MaterialButton(
                    color: Colors.orange[800],
                    //height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete,color: Colors.white,size: 16.sp,),
                        Text(
                          'Remove',
                          style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              print('Fetch Data and redirect to detail page');
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 35.w,
              height: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0.0,0.1),spreadRadius: 0.01)],
                image: DecorationImage(
                  image: NetworkImage('https://source.unsplash.com/cIEb4UJ4ruk'),
                  fit: BoxFit.cover,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}