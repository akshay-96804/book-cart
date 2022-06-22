import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderManage extends ChangeNotifier{
  int myorderTotal = 0 ;
  int get GetOrderTotal => myorderTotal ;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('ordersPlaced');

  Future<int> getOrderTotal(String docId) async{
    DocumentSnapshot<Map<String,dynamic>> doc =  await _collectionReference.doc(docId).get();
    print(doc.data()['orderList'][0]);
    int orderTotal = 0 ;

    for(int i=0;i<doc.data()['orderList'].length;i++){
      orderTotal+=doc.data()['orderList'][i]['price'];
    }

    return orderTotal ;
    // print(orderTotal);
    // myorderTotal = orderTotal ;
    // notifyListeners();
  }
}