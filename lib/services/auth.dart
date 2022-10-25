// // import 'package:book_cart_app/models/user.dart';
// import 'package:book_rent_app/models/userModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   // String 
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   UserModel _userFromFirebaseUser(User user) {
//     return user != null ? UserModel(uid: user.uid) : null;
//   }

//   Future<UserModel> signInWithEmailAndPassword(
//       String email, String password) async {
    
//     UserCredential usercredential = await _firebaseAuth
//         .signInWithEmailAndPassword(email: email, password: password).catchError((error){
//           print(error);
//           print("Invalid Credentials");
//           return null ;
//         });
//     return usercredential!=null ?_userFromFirebaseUser(usercredential.user):null;
//   }

//   Future<UserModel> signUpWithEmailAndPassword(
//       String email, String password) async {
//     UserCredential userCredential = await _firebaseAuth
//         .createUserWithEmailAndPassword(email: email, password: password);
//     User firebaseUser = userCredential.user;
//     return _userFromFirebaseUser(firebaseUser);
//   }

//   Future signOut() async {
//     try {
//       return await _firebaseAuth.signOut();
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
