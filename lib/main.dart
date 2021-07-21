import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/onboard.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder:(context,orientation,deviceType){
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        
          primaryColor: Colors.white,
        ),
        home: OnBoard(),
      );
    });
  }
}

