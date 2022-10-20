import 'package:book_rent_app/providers/authProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          Container(
                    height: MediaQuery.of(context).size.height,
                    // alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        // alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/books_background.jpg",
                        ),
                        // fit: BoxFit.cover,
                      ),
                    )),
          Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  child: Text('BookCart',style: TextStyle(fontSize: 24.0,color: Colors.white),),
                ),
                //  Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //    children: [
                //      Container(
                //        child: CircleAvatar(
                //          radius: 35.0,
                //        ),
                //      ),
                //      IconButton(
                //        color: Colors.indigoAccent,
                //        icon: Icon(Icons.edit), onPressed: (){})
                //    ],
                //  ),
                 SizedBox(height: 20.0),
                 Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getUserName,style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Email-address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getUserEmail,style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Graduating Year',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getUserGradYear,style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Contact No.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getContactNo,style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'State',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getState,style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'City',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 25.0,
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                child: Text(Provider.of<AuthProvider>(context,listen: false).getCity,style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Color(0xFF128C7E),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),              
              ],
            ),
          ),
      ]),
    );
  }
}
