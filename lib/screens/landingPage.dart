import 'package:book_rent_app/screens/loginPage.dart';
import 'package:book_rent_app/screens/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  // const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            // alignment: Alignment.topCenter,
            image: AssetImage("assets/images/bookImg.png"),
            // fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading:false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "BookCart",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 30.0
                )
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(),
                  Container(
                      // color: Colors.redAccent,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, PageTransition(child: LoginPage(), type: PageTransitionType.leftToRight));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.redAccent,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, PageTransition(child: RegisterPage(), type: PageTransitionType.leftToRight));
                        },
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                      ),
                    ],
                  ))
                ]
                )
                )
                );
  }
}
