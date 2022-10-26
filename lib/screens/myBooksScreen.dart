import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/editBookScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookScreen extends StatefulWidget {
  // const MyBookScreen({ Key? key }) : super(key: key);

  @override
  _MyBookScreenState createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> {
  // String userEmail ;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('books');

  @override
  Widget build(BuildContext context) {
    int cnt = 0;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _collectionReference.snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool flag = false;

                for (int i = 0; i < snapshot.data.size; i++) {
                  if (snapshot.data.docs[i]['email'] ==
                      Provider.of<AuthProvider>(context, listen: false)
                          .getUserEmail) {
                    cnt++;
                    flag = true;
                  }
                }
                return flag
                    ? ListView.builder(
                        itemCount: snapshot.data.size,
                        itemBuilder: (context, index) {
                          if (snapshot.data.docs[index]['email'] ==
                              Provider.of<AuthProvider>(context, listen: false)
                                  .getUserEmail) {
                            return bookTiles(
                              authorName: snapshot.data.docs[index]
                                  ['author_name'],
                              bookImg: snapshot.data.docs[index]['bookImg'],
                              courseName: snapshot.data.docs[index]
                                  ['course_name'],
                              docId: snapshot.data.docs[index].id,
                              title: snapshot.data.docs[index]['book_name'],
                              price: snapshot.data.docs[index]['price'].round(),
                            );
                          }
                          return SizedBox(
                            height: 0.0,
                          );
                        })
                    : Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Sorry ,You donot have any books',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class bookTiles extends StatelessWidget {
  String bookImg, title, authorName, courseName, docId;
  int price;
  bookTiles(
      {this.bookImg, this.title, this.authorName, this.courseName, this.docId,this.price});

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('books');

  Future<void> deleteData(BuildContext context) async {
    await _collectionReference.doc(docId).delete().whenComplete(() {
      print("Successfully deleted");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          content: Text('Deleted Succesfully')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(bookImg)))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),
                
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                MaterialButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      deleteData(context);
                                    }),
                                MaterialButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                              content: Text("Do you want to delete ?"),
                            );
                          });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
