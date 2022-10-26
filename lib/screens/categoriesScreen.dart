import 'package:book_rent_app/providers/authProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'books_screen.dart';
import 'package:page_transition/page_transition.dart';

class CategoriesScreen extends StatefulWidget {
  // const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books') ;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.50,
            // color: Colors.blueAccent,
            child: GridView(
              // physics: ScrollPhysics(parent: null),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0
              ),
                children: [
                  myGridTile(
                    title: 'Programming',
                    imgPath: 'assets/images/programming.jpg',
                  ),
                  myGridTile(
                    title: 'Course-Book',
                    imgPath: 'assets/images/textbook.jpg',
                  ),
                  myGridTile(
                    title: 'Novel',
                    imgPath: 'assets/images/novel.jpg',
                  ),
                  myGridTile(
                    title: 'BioGraphy',
                    imgPath: 'assets/images/biography.jpg',
                  ),
                ],
              ),
          ),
          SizedBox(height: 20.0)
          ,Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Latest Arrivals',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 200.0,
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
      
              future: _collectionReference.orderBy('book_name').limit(5).get(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator()
                  );
                }
               if(snapshot.data.size > 0){
                    return ListView.builder(              
               scrollDirection: Axis.horizontal,
              //  itemCount: 2,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
            return Card(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(snapshot.data.docs[index].data()['bookImg'])
                  )
                ),
                width: MediaQuery.of(context).size.width,
                // child: Text(snapshot.data.docs[index].data()['book_name']),
              ),
            );
          }); 
             }
             return Center(
              child: Text("Currently we do not have any collection."),
             ); 
              }
            )
      ),
    ]));
  }
}

class myGridTile extends StatelessWidget {
  // const myGridTile({ Key? key }) : super(key: key);
  String title;
  String imgPath;
  myGridTile({this.title,this.imgPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(child: BooksScreen(
          category: title,
        ), type: PageTransitionType.rightToLeft));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
                // height: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(

                    fit: BoxFit.fill,
                    image: AssetImage(imgPath)
                  )
                ),
              ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
                width: 2.0
              )
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text(title)))
        ],
      ),
    );
  }
}


/*
GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.0,
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0
          ), 
          itemCount: 4,
          itemBuilder: (context,index){
            return myGridTile();
          }),
 */