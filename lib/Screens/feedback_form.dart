import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackForm extends StatefulWidget {
  final String bookID;
  FeedbackForm({required this.bookID});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  Color _icon1=Colors.black38;
  Color _icon2=Colors.black38;
  Color _icon3=Colors.black38;
  Color _icon4=Colors.black38;
  Color _icon5=Colors.black38;
  TextEditingController feedback=TextEditingController();
  num star=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: 100.w,
              child: Text(
                'Give Feedback',
                style: GoogleFonts.prompt(
                  textStyle:TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20,top: 20),
              width: 100.w,
              child: Text(
                'How did we do?',
                style: GoogleFonts.prompt(
                  textStyle:TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            Container(
              width: 100.w,
              color: Colors.white,
              padding: EdgeInsets.only(left: 10,top: 5),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if (_icon1==Colors.black38){
                          _icon1=Colors.amber;
                          star=1;
                        }else{
                          _icon1=Colors.black38;
                          _icon2=Colors.black38;
                          _icon3=Colors.black38;
                          _icon4=Colors.black38;
                          _icon5=Colors.black38;
                          star=0;
                        }
                      });
                    }, 
                    icon: Icon(Icons.star_rounded,color: _icon1,size: 26.sp,)
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if (_icon2==Colors.black38){
                          _icon1=Colors.amber;
                          _icon2=Colors.amber;
                          star=2;
                        }else{
                          _icon2=Colors.black38;
                          _icon3=Colors.black38;
                          _icon4=Colors.black38;
                          _icon5=Colors.black38;
                          star=1;
                        }
                      });
                    }, 
                    icon: Icon(Icons.star_rounded,color: _icon2,size: 26.sp,)
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if (_icon2==Colors.black38){
                          _icon1=Colors.amber;
                          _icon2=Colors.amber;
                          _icon3=Colors.amber;
                          star=3;
                        }else{
                          _icon3=Colors.black38;
                          _icon4=Colors.black38;
                          _icon5=Colors.black38;
                          star=2;
                        }
                      });
                    }, 
                    icon: Icon(Icons.star_rounded,color: _icon3,size: 26.sp,)
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if (_icon2==Colors.black38){
                          _icon1=Colors.amber;
                          _icon2=Colors.amber;
                          _icon3=Colors.amber;
                          _icon4=Colors.amber;
                          star=4;
                        }else{
                          _icon4=Colors.black38;
                          _icon5=Colors.black38;
                          star=3;
                        }
                      });
                    }, 
                    icon: Icon(Icons.star_rounded,color: _icon4,size: 26.sp,)
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if (_icon2==Colors.black38){
                          _icon1=Colors.amber;
                          _icon2=Colors.amber;
                          _icon3=Colors.amber;
                          _icon4=Colors.amber;
                          _icon5=Colors.amber;
                          star=5;
                        }else{
                          _icon5=Colors.black38;
                          star=4;
                        }
                      });
                    }, 
                    icon: Icon(Icons.star_rounded,color: _icon5,size: 26.sp,)
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20,top: 20),
              width: 100.w,
              child: Text(
                'Care to share more about it?',
                style: GoogleFonts.prompt(
                  textStyle:TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  )
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: 100.w,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: feedback,
                minLines: 10,
                maxLines: null,
                style: GoogleFonts.prompt(fontSize: 13.sp,fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.lock_outline),
                      hintText: 'Leave a review...',
                      hintStyle: GoogleFonts.prompt(fontSize: 13.sp,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300,color: Colors.black26),
                      border: OutlineInputBorder()),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,top:25,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: MaterialButton(
                      elevation: 0,
                      height: 50,
                      onPressed: () async{
                        try{
                          await FirebaseFirestore.instance
                          .collection('BookCollection')
                          .doc(widget.bookID)
                          .collection('Feedback')
                          .doc()
                          .set(
                            {
                              'bookID':widget.bookID,
                              'star':star.toString(),
                              'feedback':feedback
                            }
                          ).then((value) {
                            showDialog(
                              context: context, 
                              builder: (context){
                                return AlertDialog(
                                  title: Text('Success',
                                    style: GoogleFonts.prompt(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54
                                    ),
                                  ),
                                  content: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: CircleAvatar(
                                            child: Image.asset('assets/Images/reading.gif')
                                          ),
                                        ),
                                        Text('Review Published Succesfully.',
                                          style: GoogleFonts.prompt(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                child: FeedbackForm(bookID: widget.bookID,),
                                                                type:
                                                                    PageTransitionType
                                                                        .fade))
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text("Ok"))
                                  ],
                                );
                              }
                            );
                          });
                        } catch(e){
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
                      color: Colors.teal[200],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Publish Feedback',
                        style: GoogleFonts.prompt(
                          textStyle:TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
              child: Center(
                child: Text(
                  'Your review will be posted to Google Play Store',
                  style: GoogleFonts.prompt(
                    textStyle:TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black26
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}