import 'package:book_rent_app/services/cartOperations.dart';
import 'package:book_rent_app/services/firebaseoperatons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DemoBookDetail extends StatefulWidget {
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

  DemoBookDetail(
      {this.ownerUid,
      this.authorName,
      this.bookName,
      this.description,
      this.courseName,
      this.bookImg,
      this.year,
      this.branch,
      this.owner,
      this.price,
      this.docId});

  @override
  _DemoBookDetailState createState() => _DemoBookDetailState();
}

class _DemoBookDetailState extends State<DemoBookDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Author Name',style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.cyanAccent[100]),
                    child: Text(widget.authorName),
                  ),
                  SizedBox(height: 12.0),
                  Text('Course Detail',style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.cyanAccent[100]),
                    child: Text(widget.courseName),
                  ),
                  SizedBox(height: 12.0),
                  Text('Concerned Year',style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.cyanAccent[100]),
                    child: Text(widget.year),
                  ),
                  SizedBox(height: 12.0),
                  Text('Concerned Branch',style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.cyanAccent[100]),
                    child: Text(widget.branch),
                  ),
                  SizedBox(height: 12.0),
                  Text('Description',style: TextStyle(fontWeight: FontWeight.bold)),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String status = "Processing" ; 

          showDialog(
              context: _scaffoldKey.currentContext,
              builder: (dialogContext) {
                return AlertDialog(
                  actions: [
                    MaterialButton(
                      onPressed: () async{
                        DateTime now = DateTime.now();
                          String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(now);
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
                              status = "Success" ;
                          Navigator.pop(dialogContext);
                          if(status == "Success"){
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added To Cart Successfully.')));
              }
                          print("Item added To Cart");
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
