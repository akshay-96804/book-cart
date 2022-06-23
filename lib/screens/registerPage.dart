// import 'package:book_cart_app/screens/authentication.dart';
// import 'package:book_cart_app/screens/loginPage.dart';
import 'package:book_rent_app/screens/bottom_nav.dart';
import 'package:book_rent_app/screens/loginPage.dart';
import 'package:book_rent_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users');

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();

  String username = '';
  String email = '';
  String password = '';
  String contactno = '';
  String year = '';
  String state = '' ;
  String city = '' ;

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'BookCart',
          style: TextStyle(color: Colors.black,fontSize: 30.0),
        ),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children : [
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
          inAsyncCall: _isLoading,
          child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          
                          validator: (val) =>
                              val.isEmpty ? 'Enter valid username' : null,
                          onChanged: (val) {
                            username = val;
                          },
                          // controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter User Name'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          // controller: emailController,
                          validator: (val) => val.isEmpty || !val.contains('@')
                              ? 'Enter valid Email'
                              : null,
                          onChanged: (val) {
                            email = val;
                          },
                          decoration: InputDecoration(
                             filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Email Address'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          // controller: passwordController,
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter Password 6+ char long.'
                              : null,
                          onChanged: (val) {
                            password = val;
                          },
                          decoration: InputDecoration(
                             filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Password'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          
                          // controller: passwordController,
                           keyboardType: TextInputType.number,
                          validator: (val) => val.length != 10
                              ? 'Contact no should be of 10 digits.'
                              : null,
                          onChanged: (val) {
                            contactno = val;
                          },
                          decoration: InputDecoration(
                               filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Contact No.'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          // controller: passwordController,
                          keyboardType: TextInputType.number,
                          validator: (val) => val.length != 4
                              ? 'Enter vald Graduating Year.'
                              : null,
                          onChanged: (val) {
                            year = val;
                          },
                          decoration: InputDecoration(
                             filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Graduating Year'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          // controller: passwordController,

                          validator: (val) => val.length == 0
                              ? 'Enter valid State Name.'
                              : null,
                          onChanged: (val) {
                            state = val;
                          },
                          decoration: InputDecoration(
                             filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter State'),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          // controller: passwordController,

                          validator: (val) => val.length == 0
                              ? 'Enter valid City Name.'
                              : null,
                          onChanged: (val) {
                            city = val;
                          },
                          decoration: InputDecoration(
                             filled: true,
                            fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter City'),
                        ),
                      ],
                    )),
                    SizedBox(
                height: 25.0,
              ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                          _isLoading = true;
                        });
                        
                      dynamic result = await _authService
                          .signUpWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please enter correct information';
                        });
                      } else {
                        print('All Correct');
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .set({
                          'useremail': email,
                          'username': username,
                          'contact_no': contactno,
                          'year': year,
                          'state' : state, 
                          'city' : city
                        });
                        print('User created Sucessfully.');

                        
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: BottomNavScreen(),
                                type: PageTransitionType.leftToRight));
                      }
                    } else {
                      print('Not validated.');
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
                      'Register Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
          
        ),
      ])
    );
  }
}
