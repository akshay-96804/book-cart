import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseOperations {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Map<String, dynamic> cartData = {};

  Future<void> addToCart(String bookName, String bookImg, String author,
      int price, String orderDate,String seller, String sellerId) async {
    cartData = {
      'order_date' : orderDate,
      'book_name': bookName,
      'book_img': bookImg,
      'author': author,
      'price': price,
      'seller': seller,
      'seller_id': sellerId
    };
    await _collectionReference
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('myCart')
        .add(cartData);

    //  await _collectionReference.doc().collection('orderRecieved')
  }

  Future<void> addToOrders(String userName,String orderDate) async {
    
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('myCart')
        .get();

    List<Map<String, dynamic>> allOrders = [];
    int orderTotal = 0;   
    int totalAmount = 0 ;
    
    for (int i = 0; i < query.docs.length; i++) {
      

      allOrders.add(query.docs[i].data());
      totalAmount+= query.docs[i].data()['price'];


      Map<String, dynamic> recdOrderData = {
        'date' : orderDate,
        'book_name': query.docs[i].data()['book_name'],
        'book_img': query.docs[i].data()['book_img'],
        'author': query.docs[i].data()['author'],
        'price': query.docs[i].data()['price'],
        'buyer': userName,
        'buyer_id': FirebaseAuth.instance.currentUser.uid,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(query.docs[i].data()['seller_id'])
          .collection('orderRecieved')
          .add(recdOrderData);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('myCart')
          .doc(query.docs[i].id)
          .delete();
    }

          orderTotal = totalAmount ;


       DocumentReference _orderPlacedRef = _collectionReference
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('ordersPlaced')
        .doc();

    _orderPlacedRef.set({
      'orderList': allOrders,
      'totalAmount' : orderTotal
      });

    

    // _orderPlacedRef.set({'totalAmount' : orderTotal});
  }
}
