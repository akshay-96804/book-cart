import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  String docId ;
  ChatRoom({this.docId});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String seller = "Loading...." ; 
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books');

  @override
  void initState() {
    super.initState();
    _collectionReference.doc(widget.docId).get().then((doc){
      seller = doc['owner'];
      setState(() {});
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10.0),
            Text(seller,style: TextStyle(color: Colors.white,fontSize: 18.0),)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
            )),
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36.0),
                  borderSide: BorderSide(
                    color: Colors.black12,
                    width: 2.0
                  )
                ),
                suffixIcon: Icon(Icons.send),
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Enter Your Message Here..'
              ),
            ),
          )
        ],
      ),
    );
  }
}