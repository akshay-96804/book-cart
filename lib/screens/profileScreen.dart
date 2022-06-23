import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  String userNameDisplay = "Loading..";
  String contactNo = "Loading..";
  String emailaddress = "Loading.." ;
  String graduatingYear = "Loading.." ;
  String stateName = "Loading..." ;
  String cityName = "Loading..." ;

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((doc) {
      print('Fetching User Data');
      setState(() {
           userNameDisplay = doc.data()['username'] ;
           emailaddress =  doc.data()['useremail'];
           contactNo =  doc.data()['contact_no']; 
           graduatingYear  = doc.data()['year'];        
           cityName =  doc.data()['city']; 
           stateName = doc.data()['state'];
            });
      
      // print(doc.data()['username']);
      // print(doc.data()['useremail']);

      // print(userName);
      // print(inituserImage);
      // print(userEmail);
      // print(doc.data()['useremail']);
      // print(doc.data()['username']);
      // print(doc.data()['contact_no']);
      // print(doc.data()['year']);
    });
  }

  @override
  void initState() {
    // print(FirebaseAuth.instance.currentUser.uid);
    fetchData();
    super.initState();
  }

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
                child: Text(userNameDisplay,style: TextStyle(color: Colors.white),),
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
                child: Text(emailaddress,style: TextStyle(color: Colors.white)),
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
                child: Text(graduatingYear,style: TextStyle(color: Colors.white)),
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
                child: Text(contactNo,style: TextStyle(color: Colors.white)),
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
                child: Text(stateName,style: TextStyle(color: Colors.white)),
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
                child: Text(cityName,style: TextStyle(color: Colors.white)),
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
