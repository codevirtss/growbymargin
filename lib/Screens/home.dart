import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        elevation: 0.0,
        leading: Container(
          width: 56,
          height: 56,
          margin: EdgeInsets.only(top:5,bottom: 5,left: 3.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0,0.1)
              )
            ]
          ),
          child: IconButton(onPressed: null,icon:Icon(Icons.dashboard,color: Colors.black54,size: 8.w,)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(top:5,bottom: 5,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.1)
                  )
                ],
              ),
              child: Icon(Icons.shopping_bag_outlined,),
            ),
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top:5,bottom: 5,left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.1),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network('https://source.unsplash.com/cIEb4UJ4ruk',fit: BoxFit.contain,)
              ),
            ),
          ],
        ),
      ),
      body: SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        color: Color(0xff4DB6AC),
        maxHeight: MediaQuery.of(context).size.height*0.35,
        minHeight: 80,
        body: Container(
          color: Colors.white,
          //height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(height: 2.w,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.07,
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,color: Colors.black45,),
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: GoogleFonts.firaSans(textStyle: TextStyle(color: Colors.black26))
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          child: IconButton(onPressed: null, icon:Icon(Icons.mic),color: Colors.black45,),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ), 
        panel: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.drag_handle,color: Colors.black26,size: 40,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Text('Continue Reading',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600)),),
                    ],
                  ),
                  GestureDetector(
                    child:Text('...',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white,fontSize: 30,letterSpacing: 2)),),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
              ),
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width*0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage('https://source.unsplash.com/aZ_MmSmAcjg'),fit: BoxFit.cover)
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.31,
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Text('The Psychology of Money',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600)),),
                                Text('By Morgan Housel',style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black26,fontSize: 12,fontWeight: FontWeight.w600)),),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                Icon(Icons.star,color: Colors.amber[700],size: 19,),
                                Icon(Icons.star,color: Colors.black26,size: 19,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(2, 10, 5, 10),
                    height: MediaQuery.of(context).size.width*0.20,
                    width: MediaQuery.of(context).size.width*0.20,
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
        )
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal[300],
          selectedFontSize: 13,
          unselectedFontSize: 13,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Explore"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Reading"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: "Bookmark"
            )
          ],
        ),
      ),
    );
  }
}