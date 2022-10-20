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
                      
                      childrenPadding: EdgeInsets.all(5.0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width*0.25,
                                    decoration: BoxDecoration(
                                       color: Colors.redAccent,
                                       image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data.docs[index].data()['book_img'])
                                       )
                                    ),
                                    child: Text(''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Title :- "+snapshot.data.docs[index].data()['book_name']),
                                        Text("Author :- "+ snapshot.data.docs[index].data()['author']),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text("Buyer Details :- "+snapshot.data.docs[index].data()['buyer']),
                                        Text("Order Total :-  Rs "+snapshot.data.docs[index].data()['price'].toString()),
                                        SizedBox(
                                          height: 35.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(icon: Icon(Icons.call), onPressed: (){}),
                                            IconButton(icon: Icon(Icons.location_on), onPressed: (){})
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                        // children: [
                        //   Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 75.0,
                        //             width: 70.0,
                        //             // color: Colors.amberAccent,
                        //             decoration: BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: NetworkImage(snapshot.data.docs[index]
                        //                   .data()['book_img'])
                        //               )
                        //             ),
                        //           ),
                        //           SizedBox(width: 15.0),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Flexible(
                        //                 child: Text('Book Name :- '+ snapshot.data.docs[index]
                        //                     .data()['book_name']),
                        //               ),
                        //               Text('Author Name :- '+snapshot.data.docs[index]
                        //                   .data()['author']),
                        //               Flexible(
                        //                 child: Text('Seller Detail :- '+snapshot.data.docs[index]
                        //                     .data()['buyer']),
                        //               ),
                        //               Text("Total Amount is Rs. "+ snapshot.data.docs[index]
                        //                   .data()['price']
                        //                   .toString()),
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   )
                        // ],
                        
                        subtitle: Text(
                            // 'Order Total is Rs.  ${totalAmount}'
                            'Order Recieved on  ${snapshot.data.docs[index].data()['date']}'),
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
