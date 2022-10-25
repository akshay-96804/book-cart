import 'package:book_rent_app/screens/orderPlaced.dart';
import 'package:book_rent_app/screens/orderRecieved.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  // const OrderScreen({ Key? key }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Orders",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),child: Text('Orders Placed')),
              Tab(icon: Icon(Icons.home),child: Text('Orders Recieved')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PlacedOrderScreen(),
            OrderRecievedScreen()
          ],
        ),
      ));
  }
}

// crate redd order screen