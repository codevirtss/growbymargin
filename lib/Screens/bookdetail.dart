import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailBook extends StatefulWidget {
  const DetailBook({ Key? key }) : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        //leading: GestureDetector(onTap: (){},child: Icon(Icons.arrow_back)),
        title: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 5),
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
                            Text('Detail Book',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600)),),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child:Icon(Icons.share,color: Colors.black45,)
                      ),
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
                SizedBox(height: 2.w,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.42,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(image: NetworkImage('https://source.unsplash.com/aZ_MmSmAcjg'),fit: BoxFit.cover)
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                    color: Colors.white
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('\$20.00',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.lightBlue,fontSize: 15,fontWeight: FontWeight.w600)),),
                          Text('The Psychology of Money',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600)),),
                          Text('By Morgan Housel',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black26,fontSize: 13,fontWeight: FontWeight.w600)),),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.teal[300],
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.bookmark,color: Colors.white,),
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('\$20.00',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w600)),),
                            Text('\$20.00',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.lightBlue,fontSize: 16,fontWeight: FontWeight.w600)),),
                          ],
                        )                        
                      ],
                    ),
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
  final String name, imageUrl, writer;
  BookTile({required this.imageUrl,required this.name, required this.writer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: MediaQuery.of(context).size.height*0.35,
        width: MediaQuery.of(context).size.width*0.38,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.cover)
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Text('By $writer',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black38,fontSize: 11,fontWeight: FontWeight.w600)),)
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('$name',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w600)),overflow: TextOverflow.ellipsis,)
            ),
          ],
        ),
      ),
    );
  }
}