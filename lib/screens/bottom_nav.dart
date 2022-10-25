import 'package:book_rent_app/providers/authProvider.dart';
import 'package:book_rent_app/screens/addBookScreen.dart';
import 'package:book_rent_app/screens/categoriesScreen.dart';
// import 'package:book_rent_app/screens/chatScreen.dart';
import 'package:book_rent_app/screens/books_screen.dart';
// import 'package:book_rent_app/screens/homeScreen.dart';
import 'package:book_rent_app/screens/loginPage.dart';
import 'package:book_rent_app/screens/messageRoom.dart';
import 'package:book_rent_app/screens/myBooksScreen.dart';
import 'package:book_rent_app/screens/profileScreen.dart';
import 'package:book_rent_app/services/auth.dart';
import 'package:book_rent_app/widgets/drawerView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatefulWidget {
  // const BottomNavScreen({ Key? key }) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _pages = [
    {'page': CategoriesScreen(), 'title': 'Home'},
    {'page': MyBookScreen(), 'title': 'My Books'},
    {'page': AddBookScreen(), 'title': 'Add A Book !!'},
    {'page': allChatsScreen(), 'title': 'Chats'},
    {'page': ProfileScreen(), 'title': 'Profile'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          _pages[_selectedIndex]['title'],
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<AuthProvider>(context,listen: false).signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  return LoginPage(); 
                }));
              })
        ],
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
           notchMargin: 10.0,
          shape: CircularNotchedRectangle(),
          elevation: 20.0,
          child: Container(
            height: 75,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(Icons.home),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.book_outlined),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                        // currentIndex = 1;
                        // print("${currentIndex}");
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(Icons.chat_bubble),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                        // print("${currentIndex}");
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.person),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 4;
                        // print("${currentIndex}");
                      });
                    },
                  ),
                ]),
          )),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
      
      drawer: Drawer(
        child: DrawerView(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/* 
bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          print(index);
          setState(() {
                _selectedIndex = index ; 
              });
        },
        // selectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: 'My Books',
            icon: Icon(Icons.book_outlined)),
          BottomNavigationBarItem(
            label: 'Add',
            icon: Icon(Icons.add_circle_outline)),
          BottomNavigationBarItem(
            label: 'Chats',
            icon: Icon(Icons.chat_bubble)),
            BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person)
          ),
        ],
      ),
*/
