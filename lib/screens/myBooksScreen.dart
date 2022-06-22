import 'package:book_rent_app/screens/editBookScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookScreen extends StatefulWidget {
  // const MyBookScreen({ Key? key }) : super(key: key);

  @override
  _MyBookScreenState createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> {
  String userEmail ; 

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('books');

      @override
      void initState() {
        super.initState();
        userEmail = FirebaseAuth.instance.currentUser.email;
      }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _collectionReference.snapshots(),
        // ignore: missing_return
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool flag = false ;
            // int cnt = 0 ;

            for(int i=0;i<snapshot.data.size; i++){
               if(snapshot.data.docs[i]['email'] == userEmail){
              //  cnt++ ; 
               flag = true ;
               break ;
              }
            }
            // if(flag){
              // print(cnt);
            // }
             return flag ? ListView.builder(
               itemCount: snapshot.data.size,
               itemBuilder: (context,index){
                 if(snapshot.data.docs[index]['email'] == userEmail){
                   return bookTiles(
                    authorName: snapshot.data.docs[index]['author_name'],
                    bookImg: snapshot.data.docs[index]['bookImg'],
                    courseName: snapshot.data.docs[index]['course_name'],
                    docId: snapshot.data.docs[index].id,
                    title: snapshot.data.docs[index]['book_name'],
                  ) ;
                 }
                 return  SizedBox(
                            height: 0.0,
                          ); 
               }): 
               Container(
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
          }
      )
    );
  }
}


// class bookTile extends StatelessWidget {
//   String authorName ;
//   String courseName ;
//   String title ;
//   String docId ;
//   String bookImg ;

//   bookTile({this.title,this.bookImg,this.authorName,this.courseName,this.docId});

//   CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books');

//   Future<void> deleteData(BuildContext context) async{
//     await _collectionReference.doc(docId).delete().whenComplete((){
//       print("Successfully deleted");
//       Navigator.pop(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: new BoxDecoration(
//         boxShadow: [
//           new BoxShadow(
//             color: Colors.black,
//             blurRadius: 20.0,
//           ),
//         ],
//       ),
//       height: MediaQuery.of(context).size.height*0.25,
//       child: Card(
//         child: Container(
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(bookImg)
//                   )
//               )),
//               Positioned(
//                 // left: 2.0,
//                 bottom: 6.0,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(title,style: TextStyle(
//                         color: Colors.redAccent,
//                         fontSize: 22.0,
//                         fontWeight: FontWeight.bold
//                       ),),
//                       SizedBox(width: 5.0),
                      
//                        IconButton(icon: Icon(Icons.edit), onPressed: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context){
//                            return EditBookScreen(
//                              author: authorName,
//                              book: title,
//                              course: courseName,
//                              docId: docId,
//                            ); 
//                          }));
//                        }),
//                        IconButton(icon: Icon(Icons.delete), onPressed: (){
//                          return showDialog(context: context, builder: (context){
//                            return AlertDialog(
//                              actions: [
//                               MaterialButton(
//                                 child: Text('Yes'),
//                                 onPressed: (){
//                                   deleteData(context);
//                                 }),
//                               MaterialButton(
//                                 child: Text('No'),
//                                 onPressed: (){
//                                   Navigator.pop(context);
//                                 })
//                              ],
//                              content: Text("Do you want to delete ?"),
//                            );
//                          });
//                        })
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         color: Colors.blueAccent,
//       ));
//   }
// }


class bookTiles extends StatelessWidget {
 String bookImg,title,authorName,courseName,docId; 
 bookTiles({this.bookImg,this.title,this.authorName,this.courseName,this.docId});

  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books');

  Future<void> deleteData(BuildContext context) async{
    await _collectionReference.doc(docId).delete().whenComplete((){
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
        //  color: Colors.blueAccent,
        child: Column(
          children: [
            Container(
                    height: MediaQuery.of(context).size.height*0.25,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(bookImg)
                  )
              )),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(title,style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(width: 5.0),
                      
                       IconButton(icon: Icon(Icons.edit), onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return EditBookScreen(
                             author: authorName,
                             book: title,
                             course: courseName,
                             docId: docId,
                           ); 
                         }));
                       }),
                       IconButton(icon: Icon(Icons.delete), onPressed: (){
                         return showDialog(context: context, builder: (context){
                           return AlertDialog(
                             actions: [
                              MaterialButton(
                                child: Text('Yes'),
                                onPressed: (){
                                  deleteData(context);
                                }),
                              MaterialButton(
                                child: Text('No'),
                                onPressed: (){
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


/*
  // if(snapshot.data.docs[i]['email'] == userEmail){
                // return ListView.builder(
                //   itemCount: snapshot.data.docs.length,
                //   itemBuilder: (context,index){
                //   return bookTiles(
                //     authorName: snapshot.data.docs[index]['author_name'],
                //     bookImg: snapshot.data.docs[index]['bookImg'],
                //     courseName: snapshot.data.docs[index]['course_name'],
                //     docId: snapshot.data.docs[index].id,
                //     title: snapshot.data.docs[index]['book_name'],
                //   ) ;
                  // bookTile(
                  //   authorName: snapshot.data.docs[index]['author_name'],
                  //   bookImg: snapshot.data.docs[index]['bookImg'],
                  //   courseName: snapshot.data.docs[index]['course_name'],
                  //   docId: snapshot.data.docs[index].id,
                  //   title: snapshot.data.docs[index]['book_name'],
                  //   );
                // }
                // );
              // }
 */