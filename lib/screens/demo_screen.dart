// import 'package:book_rent_app/screens/book_page_view.dart';
import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/demoBookDetails.dart';
import 'package:book_rent_app/services/firebaseoperatons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DemoHomePage extends StatefulWidget {
  // const DemoHomePage({ Key? key }) : super(key: key);
  String category;
  DemoHomePage({this.category});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('books');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Books", style: TextStyle(color: Colors.black, fontSize: 20.0)),
      ),
      body: Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: (val) {
            setState(() {
              searchText = val;
            });
          },
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'Search Your Book...',
              contentPadding: EdgeInsets.all(20.0)),
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _collectionReference
                .where('category',isEqualTo: widget.category).snapshots(),
                // .where('owner_uid',
                    // isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
                // .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data.size > 0) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          // itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data.docs[index]['book_name']
                                .toLowerCase()
                                .contains(searchText.toLowerCase()) && snapshot.data.docs[index]['owner_uid'] != Provider.of<AuthProvider>(context,listen: false).getUserId) {
                              return GestureDetector(
                                onTap: () {
                                  // print();

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: DemoBookDetail(
                                            description: snapshot.data
                                                .docs[index]['description'],
                                            ownerUid: snapshot.data.docs[index]
                                                ['owner_uid'],
                                            price: snapshot.data.docs[index]
                                                .data()['price']
                                                .round(),
                                            owner: snapshot.data.docs[index]
                                                ['owner'],
                                            authorName: snapshot.data
                                                .docs[index]['author_name'],
                                            bookName: snapshot.data.docs[index]
                                                ['book_name'],
                                            courseName: snapshot.data
                                                .docs[index]['course_name'],
                                            bookImg: snapshot.data.docs[index]
                                                ['bookImg'],
                                            branch: snapshot.data.docs[index]
                                                ['branch'],
                                            year: snapshot.data.docs[index]
                                                ['year'],
                                            docId: snapshot.data.docs[index].id,
                                          ),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                                child: Card(
                                  elevation: 2.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(snapshot.data.docs[index]
                                              .data()['owner'])
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: NetworkImage(snapshot
                                                      .data.docs[index]
                                                      .data()['bookImg']))),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            snapshot.data.docs[index]
                                                ['book_name'],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Author :- ',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                    Text(
                                                      snapshot.data.docs[index]
                                                          ['author_name'],
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.bookmark),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .uid)
                                                        .collection('bookmarks')
                                                        .add({
                                                      'book_name': snapshot
                                                              .data.docs[index]
                                                          ['book_name'],
                                                      'author_name': snapshot
                                                              .data.docs[index]
                                                          ['author_name'],
                                                      'owner_name': snapshot
                                                          .data.docs[index]
                                                          .data()['owner'],
                                                          'bookImg' :snapshot
                                                      .data.docs[index]
                                                      .data()['bookImg']
                                                    });
                                                  }),
                                              IconButton(
                                                  icon:
                                                      Icon(Icons.shopping_cart),
                                                  onPressed: () {})
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              height: 0.0,
                            );
                          }));
                }
                return Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Currently there are no books available for selected category on our platform. Please look after some time. '),
                    ),
                  ),
                );
              }

              return Center(
                child: Text('Some Error'),
              );
            })
      ],
    ),
    );
  }
}


class GridTile extends StatelessWidget {
  // const GridTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}