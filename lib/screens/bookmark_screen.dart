import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookMarkScreen extends StatelessWidget {
  // const BookMarkScreen({ Key? key }) : super(key: key);

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            if(snapshot.data.size > 0){
              return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(),
                          Text(snapshot.data.docs[index].data()['owner_name'])
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         child: DemoBookDetail(
                          //             snapshot.data.docs[index].id),
                          //         type: PageTransitionType
                          //             .rightToLeft));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(snapshot.data.docs[index]
                                      .data()['bookImg']))),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data.docs[index]['book_name'],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Author :- ',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]['author_name'],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.bookmark_border),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {})
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
            }
            return  Center(
            child: Text("You have not added any bookmarks"),
          );
          }
          return Center(
            child: Text("Some Error Occurred"),
          );
        },
        future: _collectionReference
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('bookmarks')
            .get(),
      ),
    );
  }
}
