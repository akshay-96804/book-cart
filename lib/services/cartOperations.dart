import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartOperations extends ChangeNotifier{
  int cartAmount = 0 ;

  int getCartAmount() => cartAmount ;

  void cartTotal() async{
    QuerySnapshot<Map<String,dynamic>> query =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('myCart').get();
    int amount = 0;

    for(int i=0;i<query.docs.length;i++){
       amount+=query.docs[i].data()['price'];
    }
    cartAmount = amount;
    notifyListeners();

    // print(getCartAmount());
  }

  void deleteItem(String docId) async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('myCart').doc(docId).delete();
    notifyListeners();
  }
}