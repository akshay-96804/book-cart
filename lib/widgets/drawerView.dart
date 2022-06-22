import 'package:book_rent_app/screens/bookmark_screen.dart';
import 'package:book_rent_app/screens/cartPage.dart';
// import 'package:book_rent_app/screens/homeScreen.dart';
import 'package:book_rent_app/screens/ordersScreen.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  buildList(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'sans',
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.cyan[400],
            child: Center(
              child:Column(
                children: <Widget>[   
                  Spacer(),       
                  Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.only(top:10),
                      child: Text(
                        'Book Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.only(top:30),
                    child: Container(
                      // color: Colors.red,
                      height: 70.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/bookImg.png')
                        ),
                        // color: Colors.red,
                        shape: BoxShape.circle
                      ),
                    )
                  ),
                ]
              )
               
            ),
          ),
           buildList(
            'Home',
            Icons.home,
            () {
              Navigator.pop(context);
              
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
          buildList(
            'Notifications',
            Icons.notifications,
            () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return Notifications();
              //     },
              //   ),
              // );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
          buildList(
            'BookMarks',
            Icons.bookmark,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return BookMarkScreen();
                    
                  },
                  
                ),
              );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 3.0,
            ),
          buildList(
            'My Cart ',
            Icons.shopping_cart,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return CartPage();
                  },
                ),
              );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 3.0,
            ),
          buildList(
            'My Orders',
            Icons.menu_book_sharp,
            () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return OrderScreen();
                  },
                ),
              );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 3.0,
            ),
          buildList(
            'Contact Us',
            Icons.contact_mail,
            () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return ContactPage();
              //     },
              //   ),
              // );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
          buildList(
            'FAQs',
            Icons.question_answer,
            () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return FAQPage();
              //     },
              //   ),
              // );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
          buildList(
            'About App',
            Icons.library_books,
            () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return AboutPage();
              //     },
              //   ),
              // );
            },
          ),
           new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
          buildList(
            'Settings',
            Icons.settings,
            () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return SettingsPage();
              //     },
              //   ),
              // );
            },
          ),
          new Divider(
              color: Colors.greenAccent,
              height: 2.0,
            ),
        ],
      );
  }
}

/*
ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: FlutterLogo(),
          accountEmail: Text('Username'),
          accountName: Text('Email'),
        ),
        ListTile(
          
          onTap: (){},
                        leading: Icon(Icons.home), title: Text("Home"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.notifications,color: Colors.black,), title: Text("Notifications"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.person), title: Text("Profile"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.contact_mail), title: Text("Contact Us"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.question_answer), title: Text("FAQs"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.info), title: Text("About App"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.settings), title: Text("Settings"),  

        ),
        ListTile(
           onTap: (){},
                        leading: Icon(Icons.logout), title: Text("Log Out"),  

        ),
      ],
    );
*/