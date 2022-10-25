// import 'package:book_rent_app/screens/chatRoom.dart';
import 'dart:math';

import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/messagesScreen.dart';
import 'package:book_rent_app/services/cartOperations.dart';
import 'package:book_rent_app/services/firebaseoperatons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BooksDetailsScreen extends StatefulWidget {
  String description;
  String ownerUid;
  String bookName;
  String authorName;
  String courseName;
  String branch;
  String bookImg;
  String year;
  String owner;
  String docId;
  int price;

  BooksDetailsScreen(
      {@required this.ownerUid,
      @required this.authorName,
      @required this.bookName,
      @required this.description,
      @required this.courseName,
      @required this.bookImg,
      @required this.year,
      @required this.branch,
      @required this.owner,
      @required this.price,
      @required this.docId});

  @override
  _BooksDetailsScreenState createState() => _BooksDetailsScreenState();
}

class _BooksDetailsScreenState extends State<BooksDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isbookmarked = false;

  String chatRoomId = '';

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  void initState(){
    super.initState();
    check();
  }

  void check() async{
    QuerySnapshot _docData = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('bookmarks').get();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
            'Details',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          actions: [
            IconButton(
                icon: _isbookmarked
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border_outlined),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('bookmarks')
                      .doc(widget.docId)
                      .set({
                    'book_name': widget.bookName,
                    'author_name': widget.authorName,
                    'owner_name': widget.owner,
                    'bookImg': widget.bookImg,
                    'description': widget.description,
                    'owner_uid': widget.ownerUid,
                    'course_name': widget.courseName,
                    'branch': widget.branch,
                    'book_img': widget.bookImg,
                    'year': widget.year,
                    'owner': widget.owner,
                    'docId': widget.docId,
                    'price': widget.price
                  }).then((value) {
                    setState(() {
                      _isbookmarked = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Sucessfully BookMarked")));
                  });
                })
          ]),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
                child: Text(
              widget.bookName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            )),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.rectangle,
                        color: Colors.black,
                        image: DecorationImage(
                          // fit: BoxFit.cover,
                          image: NetworkImage(widget.bookImg),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.8,
              height: MediaQuery.of(context).size.height / 3.5,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                shape: BoxShape.rectangle,
                color: Colors.grey[300],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.bookImg),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Author Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.cyanAccent[100]),
                  child: Text(widget.authorName),
                ),
                SizedBox(height: 12.0),
                Text('Course Detail',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.cyanAccent[100]),
                  child: Text(widget.courseName),
                ),
                SizedBox(height: 12.0),
                Text('Concerned Year',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.cyanAccent[100]),
                  child: Text(widget.year),
                ),
                SizedBox(height: 12.0),
                Text('Concerned Branch',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.cyanAccent[100]),
                  child: Text(widget.branch),
                ),
                SizedBox(height: 12.0),
                Text('Description',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.cyanAccent[100]),
                  child: Text(widget.description),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          GestureDetector(
            onTap: () {
              chatRoomId = generateRandomString(12);

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<AuthProvider>(context, listen: false)
                      .getUserId)
                  .collection('chats')
                  .doc(chatRoomId)
                  .set({
                'reciever': widget.owner,
                'sender': Provider.of<AuthProvider>(context, listen: false)
                    .getUserName,
                'chatId': chatRoomId,
                'person': widget.ownerUid
              });

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.ownerUid)
                  .collection('chats')
                  .doc(chatRoomId)
                  .set({
                'reciever': Provider.of<AuthProvider>(context, listen: false)
                    .getUserName,
                'sender': widget.owner,
                'chatId': chatRoomId,
                'person':
                    Provider.of<AuthProvider>(context, listen: false).getUserId
              });

              Navigator.push(
                  context,
                  PageTransition(
                      child: ChatRoom(chatRoomId, widget.ownerUid),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Colors.redAccent),
              alignment: Alignment.center,
              width: double.infinity * 0.15,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Contact Seller'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(
              context: _scaffoldKey.currentContext,
              builder: (dialogContext) {
                return AlertDialog(
                  actions: [
                    MaterialButton(
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('yyyy-MM-dd - kk:mm').format(now);
                        // print(widget.owner);
                        await FirebaseOperations()
                            .addToCart(
                                widget.bookName,
                                widget.bookImg,
                                widget.authorName,
                                widget.price,
                                formattedDate,
                                widget.owner,
                                widget.ownerUid)
                            .whenComplete(() {
                          Navigator.pop(dialogContext);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Item added To Cart Successfully.')));
                        });
                      },
                      child: Text('Yes'),
                    ),
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No')),
                  ],
                  content: Text('Do You want to add the book in cart ?'),
                );
              });
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
