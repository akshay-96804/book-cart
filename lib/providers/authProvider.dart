import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currUser;

  String userEmail;
  String userId;
  String userName;
  String userContactno;
  String userState;
  String userCity;
  String userGradYear;

  String get getUserId {
    return userId;
  }

  String get getUserName {
    return userName;
  }

  String get getUserEmail {
    return userEmail;
  }

  String get getContactNo {
    return userContactno;
  }

  String get getState {
    return userState;
  }

  String get getCity {
    return userCity;
  }

  String get getUserGradYear {
    return userGradYear;
  }

  User get getCurruser{
    return FirebaseAuth.instance.currentUser;
  }

  Future<String> createUser(String email, String password) async {
    String errorMessage;

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      userId = userCredential.user.uid;

      notifyListeners();
      return "Success" ;
    } on FirebaseAuthException catch(e){
       if(e.code == "email-already-in-use"){
           errorMessage = "email-already-in-use";
       }
       else if(e.code == "invalid-email"){
          errorMessage = "invalid-email" ;
       }
       else if(e.code == "operation-not-allowed"){
        errorMessage = "operation-not-allowed";
       }
       else if(e.code == "weak-password"){
        errorMessage = "weak-password" ;
       }
    }

    return errorMessage ;
  }

  Future<String> logInUser(String email, String password) async {
    String errorMessage;

    try {
      UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    userId = userCredential.user.uid;

    notifyListeners();
    return "Success" ;

    } on FirebaseAuthException catch (e) {
      if(e.code == "wrong-password"){
         errorMessage = "wrong-password" ;
      }
      else if(e.code == "invalid-email"){
        errorMessage = "invalid-email";
      }
      else if(e.code == "user-disabled"){
        errorMessage = "user-disabled" ;
      }
      else if(e.code == "user-not-found"){
        errorMessage = "user-not-found" ;
      }
    }

    return errorMessage ;
  }

  Future<void> fetchUser() async {
    DocumentSnapshot _docData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    userCity = _docData['city'];
    userContactno = _docData['contact_no'];
    userState = _docData['state'];
    userEmail = _docData['useremail'];
    userName = _docData['username'];
    userGradYear = _docData['year'];

    notifyListeners();
  }

  Future<void> storeUser(String email, String username, String contactno,
      String year, String state, String city) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'useremail': email,
      'username': username,
      'contact_no': contactno,
      'year': year,
      'state': state,
      'city': city
    });
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
