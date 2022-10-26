import 'dart:io';

import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/bottom_nav.dart';
import 'package:book_rent_app/screens/cartPage.dart';
import 'package:book_rent_app/screens/landingPage.dart';
import 'package:book_rent_app/services/cartOperations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart' ;
import 'package:provider/provider.dart'; 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        primaryColor: Colors.cyan[400],
        accentColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.latoTextTheme()
        ),
    textTheme: GoogleFonts.latoTextTheme(),
  ),
      home: Wrapper(),
    ),
      providers: [
        ChangeNotifierProvider(
          child: CartPage(),
          create: (_)=>CartOperations(),
        ),
        ChangeNotifierProvider(
          child: BottomNavScreen(),
          create: (_)=> AuthProvider(),
        ),
      ]
    );
  }
}


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider.of<AuthProvider>(context).getCurruser!=null?BottomNavScreen():LandingPage();
  }
}