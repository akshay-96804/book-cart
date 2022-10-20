import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudMethods {
  CollectionReference _bookscollection =
      FirebaseFirestore.instance.collection('books');

  Future<DocumentReference> addBooks(
      String userUid,
      String username,
      String email,
      String bookImg,
      String branch,
      String bookName,
      String courseName,
      String authorName,
      String description,
      String category,
      String year,
      double price
      ) 
      {
    return _bookscollection.add({
      'owner_uid': userUid,
      'owner': username,
      'email': email,
      'bookImg': bookImg,
      'branch' : branch,
      'book_name': bookName,
      'course_name': courseName,
      'author_name': authorName,
      'year': year,
      'description' :description,
      'price' : price,
      'category': category
    });
  }
}
