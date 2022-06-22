import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderRecievedScreen extends StatefulWidget {
  @override
  _OrderRecievedScreenState createState() => _OrderRecievedScreenState();
}

class _OrderRecievedScreenState extends State<OrderRecievedScreen> {
  @override
  void initState() {
    super.initState();
    // getOrderTotal();
  }

  int totalAmount = 0 ;

  CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('orderRecieved');

  // getOrderTotal() async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await _collectionReference.get();
  //   int orderTotal = 0;

  //   querySnapshot.docs.forEach((element) {
  //     orderTotal += element.data()['price'];
  //   });

  //   totalAmount = orderTotal ;
  //   print(totalAmount);
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _collectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data.size > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 75.0,
                                    width: 70.0,
                                    // color: Colors.amberAccent,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data.docs[index]
                                          .data()['book_img'])
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Book Name :- '+ snapshot.data.docs[index]
                                          .data()['book_name']),
                                      Text('Author Name :- '+snapshot.data.docs[index]
                                          .data()['author']),
                                      Text('Seller Detail :- '+snapshot.data.docs[index]
                                          .data()['buyer']),
                                      Text("Total Amount is Rs. "+ snapshot.data.docs[index]
                                          .data()['price']
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                        
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            // 'Order Total is Rs.  ${totalAmount}'
                            'Order Recieved on  ${snapshot.data.docs[index].data()['date']}')
                          ],
                        ),
                        title: Text("Order No. ${index + 1}"));
                  });
            } else {
              return Center(
                child: Text("No orders currently"),
              );
            }
          }
          return Center(child: Text('Some Error Occurred'));
        });
  }
}
