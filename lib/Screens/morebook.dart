import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growbymargin/Screens/bookdetail.dart';
import 'package:sizer/sizer.dart';

class MoreBook extends StatefulWidget {
  const MoreBook({ Key? key }) : super(key: key);

  @override
  _MoreBookState createState() => _MoreBookState();
}

class _MoreBookState extends State<MoreBook> {
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
                            SizedBox(height: 15,),
                            Text('More Books',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600)),),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child:Text('...',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black45,fontSize: 30,letterSpacing: 2,fontWeight: FontWeight.w900)),),
                      ),
                    ],
                  ),
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
                SizedBox(height: 2.w,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.47,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Top E-Book Reading',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w600)),),
                      Text('This top e-book for you, we have many types for you needed (science, design, business etc.)',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.w600)),),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
                            height: MediaQuery.of(context).size.height*0.32,
                            width: MediaQuery.of(context).size.width*0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(image: NetworkImage('https://source.unsplash.com/aZ_MmSmAcjg'),fit: BoxFit.cover)
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.335,
                            width: MediaQuery.of(context).size.width*0.44,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('The Psychology of Money',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),),
                                    SizedBox(height: 5,),
                                    Text('By Morgan Housel',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black26,fontSize: 13,fontWeight: FontWeight.w600)),),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                        Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                        Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                        Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                        Icon(Icons.star,color: Colors.black26,size: 19,)
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text('\$20.00',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.lightBlue,fontSize: 15,fontWeight: FontWeight.w600)),),
                                  ],
                                ),
                                MaterialButton(
                                  color: Colors.orange[800],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  elevation: 0,
                                  onPressed: (){
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailBook(bookID: '1256',)));
                                  },
                                  child:Text('Details',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w600)),),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
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
                          SizedBox(height: 10,),
                          Text('Recomended Books',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black38,fontSize: 15,fontWeight: FontWeight.w600)),),
                        ],
                      ),
                      GestureDetector(
                        child:Text('...',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black45,fontSize: 30,letterSpacing: 2,fontWeight: FontWeight.w900)),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.35,
                  padding: EdgeInsets.only(left: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BookTile(imageUrl: 'https://source.unsplash.com/aZ_MmSmAcjg',name: 'The Psychology of Money',writer: 'Morgan Housel',),
                      BookTile(imageUrl: 'https://source.unsplash.com/9dXSoi6VXEA',name: 'Stupore e Tremori',writer: 'Amelie Nothomb',),
                      BookTile(imageUrl: 'https://source.unsplash.com/aZ_MmSmAcjg',name: 'The Psychology of Money',writer: 'Morgan Housel',),
                      BookTile(imageUrl: 'https://source.unsplash.com/9dXSoi6VXEA',name: 'Stupore e Tremori',writer: 'Amelie Nothomb',),                      
                    ],
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
                          SizedBox(height: 10,),
                          Text('Top Rated Books',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black38,fontSize: 15,fontWeight: FontWeight.w600)),),
                        ],
                      ),
                      GestureDetector(
                        child:Text('...',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black45,fontSize: 30,letterSpacing: 2,fontWeight: FontWeight.w900)),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.35,
                  padding: EdgeInsets.only(left: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BookTile(imageUrl: 'https://source.unsplash.com/aZ_MmSmAcjg',name: 'The Psychology of Money',writer: 'Morgan Housel',),
                      BookTile(imageUrl: 'https://source.unsplash.com/9dXSoi6VXEA',name: 'Stupore e Tremori',writer: 'Amelie Nothomb',),
                      BookTile(imageUrl: 'https://source.unsplash.com/aZ_MmSmAcjg',name: 'The Psychology of Money',writer: 'Morgan Housel',),
                      BookTile(imageUrl: 'https://source.unsplash.com/9dXSoi6VXEA',name: 'Stupore e Tremori',writer: 'Amelie Nothomb',),                      
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