import 'dart:math';

import 'package:book_rent_app/services/orderManage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacedOrderScreen extends StatefulWidget {
  String orderid;
  PlacedOrderScreen({this.orderid});

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('ordersPlaced');

  @override
  void initState() {
    super.initState();
  }

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
              List<Map<String, dynamic>> orderList = [];

              for (int i = 0; i < snapshot.data.docs.length; i++) {
                orderList.add(snapshot.data.docs[i].data());
              }

              return ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    int orderTotal = 0;
                    // = await Provider.of<OrderManage>(context, listen: false).getOrderTotal(snapshot.data.docs[index].id) ;
                    return ExpansionTile(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderList[index]['orderList'].length,
                            itemBuilder: (context, idx) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Book No. ${idx + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    // Text("Order no.  $idx"),
                                    Text('Book Name :- '+orderList[index]['orderList'][idx]
                                        ['book_name']),
                                    Text('Author Name :- '+orderList[index]['orderList'][idx]
                                        ['author']),
                                    Text('Seller Detail :- '+orderList[index]['orderList'][idx]
                                        ['seller']),
                                    Text('Rs. '+orderList[index]['orderList'][idx]
                                            ['price']
                                        .toString()),
                                    SizedBox(height: 10.0),
                                    
                                  ],
                                ),
                              );
                            }),
                        Text(
                            'Order Total is Rs.   ${snapshot.data.docs[index].data()['totalAmount'].toString()}')
                      ],
                      // title: Text(orderList.length.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                             'Order ID is ${snapshot.data.docs[index].id}'),
                          Text(
                              'Order Placed on  ${orderList[index]['orderList'][0]['order_date']}')
                        ],
                      ),
                      title: Text('Order No. ${index + 1}',style: TextStyle(fontWeight: FontWeight.bold),),
                    );
                  });
            }
            return Center(
              child: Text('No Orders Placed currently. '),
            );
          }
          return Center(
            child: Text('Some Error Occurred'),
          );
        });
  }
}

/* 
Container(
                              padding: EdgeInsets.all(12.0),
                              width: double.infinity,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Text('Order Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),)
                                  //   ],
                                  // ),
                                  Text(orderList[index]),
                                  // Text(snapshot.data.docs[index].data()['orderList'][index]['author']),
                                  // Text(snapshot.data.docs[index].data()['orderList'][index]['seller']),
                                  // Text(snapshot.data.docs[index].data()['orderList'][index]['price'].toString()),
                                  // SizedBox(height: 10.0),
                                  // Text('Order ID is ${snapshot.data.docs[index].id}')
                                ],
                              ),
                            )
*/