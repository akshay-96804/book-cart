import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/messagesScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class allChatsScreen extends StatelessWidget {
  // const allChatsScreen({ Key? key }) : super(key: key);
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
            stream: _firebaseFirestore.collection('users').doc(Provider.of<AuthProvider>(context,listen: false).getUserId).collection('chats').snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.data.size > 0){
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: ChatRoom(
                          snapshot.data.docs[index].data()['chatId'], 
                          snapshot.data.docs[index].data()['person'],
                          ), type: PageTransitionType.leftToRight));
                      },
                      leading: Icon(Icons.person),
                      title: Text(snapshot.data.docs[index].data()['reciever']),
                    );
                });
                }
                return Center(child: Text('No Chats Found'));  
              }
              return Center(child: Text('Some Error Occurred'));
          }),
        )
      ],
    );
  }
}