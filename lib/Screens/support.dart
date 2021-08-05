import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SuppostTeam extends StatelessWidget {
  const SuppostTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Reach The Support Team"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.h,
            ),
            Container(
                alignment: Alignment.center,
                height: 60.h,
                child: Column(
                  children: [
                    Image.asset("assets/Images/support.gif"),
                    // Icon(
                    //   Icons.support_agent,
                    //   size: 60.sp,
                    //   color: Color(0XFF92E3A9),
                    // ),
                    Text(
                      "How Can we help \n            you?",
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
