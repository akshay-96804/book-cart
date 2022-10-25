import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/services/cartOperations.dart';
import 'package:book_rent_app/services/firebaseoperatons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  // String userName = "";

  @override
  void initState() {
    super.initState();
    Provider.of<CartOperations>(context, listen: false).cartTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Provider.of<CartOperations>(context,
                                                  listen: false)
                                              .deleteItem(
                                                  snapshot.data.docs[index].id);
                                          Provider.of<CartOperations>(context,
                                                  listen: false)
                                              .cartTotal();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                      MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No')),
                                    ],
                                    content: Text(
                                        'Do You want to delete the book in cart ?'),
                                  );
                                });
                          },
                          child: Card(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 130.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data.docs[index]
                                                  .data()['book_img']))),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      // color: Colors.lightBlueAccent,

                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data.docs[index]
                                                    .data()['book_name'],
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(
                                                snapshot.data.docs[index]
                                                    .data()['author'],
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                          ),
                                          Container(
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Seller :- ' +
                                                    snapshot.data.docs[index]
                                                        .data()['seller']),
                                              ],
                                            ),
                                          ),
                                          Text('Price :- ' +
                                              snapshot.data.docs[index]
                                                  .data()['price']
                                                  .toString())
                                          // SizedBox(height: 50.0),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Center(
                  child: Text('You have nothing in your cart. '),
                );
              },
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('myCart')
                  .orderBy('book_name', descending: false)
                  .snapshots(),
            ),
          ),

          // Spacer(),
          GestureDetector(
            onTap: () {
              String status = "Processing";
              DateTime now = DateTime.now();
              String formattedDate =
                  DateFormat('yyyy-MM-dd - kk:mm').format(now);

              print(formattedDate);

              FirebaseOperations().addToOrders(
                  Provider.of<AuthProvider>(context, listen: false).getUserName,
                  formattedDate).then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Placed Succesfully"))),     
                  });
            },
            child: Container(
              margin: EdgeInsets.only(top: 12.0),
              height: 80.0,
              decoration: BoxDecoration(
                  // color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(12.0)),
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(15.0)),
                alignment: Alignment.center,
                child: Text(
                  'Place Order    Rs  ${Provider.of<CartOperations>(context).getCartAmount().toString()}',
                  style: TextStyle(color: Colors.white),
                ),
                width: double.infinity,
                height: 50.0,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
