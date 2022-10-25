import 'package:book_rent_app/screens/bookDetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BookMarkScreen extends StatelessWidget {
  // const BookMarkScreen({ Key? key }) : super(key: key);

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My BookMarks",style: TextStyle(color: Colors.black,fontSize: 18.0))
      ),
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
                          CircleAvatar(
                                                                       child: Icon(Icons.person),
 
                          ),
                          Text(snapshot.data.docs[index].data()['owner_name'])
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, PageTransition(child: BooksDetailsScreen(
                            authorName: snapshot.data.docs[index].data()['author_name'],
                            bookImg: snapshot.data.docs[index].data()['bookImg'],
                            bookName: snapshot.data.docs[index].data()['book_name'],
                            branch: snapshot.data.docs[index].data()['branch'],
                            courseName: snapshot.data.docs[index].data()['course_name'],
                            description: snapshot.data.docs[index].data()['description'],
                            docId: snapshot.data.docs[index].data()['docId'],
                            owner: snapshot.data.docs[index].data()['owner'],
                            ownerUid: snapshot.data.docs[index].data()['owner_uid'],
                            price: snapshot.data.docs[index].data()['price'],
                            year: snapshot.data.docs[index].data()['year'],
                          ), type: PageTransitionType.rightToLeft));
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
