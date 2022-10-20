// import 'package:book_cart_app/screens/authentication.dart';
// import 'package:book_cart_app/screens/registerPage.dart';
import 'package:book_rent_app/models/userModel.dart';
import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/bottom_nav.dart';
import 'package:book_rent_app/screens/registerPage.dart';
import 'package:book_rent_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isError = false;

  final _formKey = GlobalKey<FormState>();

  String errpr = "";
  bool _isloading = false;

  // AuthService _authService = AuthService();
  AuthProvider _authProvider = AuthProvider();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading:false,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'BookCart',
            style: TextStyle(color: Colors.black, fontSize: 30.0),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
        // alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            // alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/books_background.jpg",),
            // fit: BoxFit.cover,
          ),
        )),
          ModalProgressHUD(
          inAsyncCall: _isloading,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('BookCart'),
                // ),
                SizedBox(
                  height: 25.0,
                ),
                //  Text("BookCart",
                //       style: GoogleFonts.lato(color: Colors.black, fontSize: 30.0)),
                // Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        
                        onChanged: (val) {
                          email = val;
                        },
                        validator: (val) => val.isEmpty || !val.contains('@')
                            ? 'Enter valid Email'
                            : null,
                        // controller: emailController,
                        decoration: InputDecoration(
                            
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Enter Email Address',
                            // hintStyle: TextStyle(color: Colors.)
                            ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        obscureText: true,
                        onChanged: (val) {
                          password = val;
                        },
                        validator: (val) => val.length < 6
                            ? 'Enter Password 6+ char long'
                            : null,

                        // controller: passwordController,
                        decoration: InputDecoration(
                            filled: true,
                          
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Enter Password'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: _isError,
                    child: Text(
                  errpr,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                )),
                Visibility(
                  visible: _isError,
                  child: SizedBox(
                    height: 25.0,
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isloading = true;
                      });

                      String res = await Provider.of<AuthProvider>(context,listen: false).logInUser(email, password);

                      // User _userData = await _authProvider.logInUser(email, password);
                      
                      if (res !="Success") {
                        // print(res);
                        setState(() {
                          _isloading = false;
                          _isError = true ;

                          errpr = res;
                        });
                      } else {
                        print("Sign in Successfully.");
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: BottomNavScreen(),
                                type: PageTransitionType.bottomToTop));
                      }
                    } else {
                      print('Login Failed');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      )
    );
  }
}
