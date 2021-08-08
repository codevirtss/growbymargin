import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:growbymargin/Screens/home.dart';
import 'package:growbymargin/Utils/GlobalVariables.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51JLvWbSE2NjvkvdFAlF97IZVywXKSL4DfwBKbiMH3JPuoCUlmzCutxJ6i0FOsus1iTQyOIvmbPpjh1g0TSe3jxNG00fu8LlI5X";
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(
      // DevicePreview(enabled: true, builder: (BuildContext context) => MyApp()));
      MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    DataService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Home(),
      );
    });
  }
}
