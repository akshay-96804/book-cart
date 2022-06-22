import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  // const EditBookScreen({ Key? key }) : super(key: key);

  String author,book,course,docId;
  EditBookScreen({this.author,this.book,this.course,this.docId});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books');

  String updatedBook ; 
  String updatedAuthor ; 
  String updatedCourse ;

  @override
  void initState() {
    super.initState();
    print("Fetching data in book update screen");
    _collectionReference.doc(widget.docId).get().then((doc){
        updatedBook = doc['book_name'] ;
        updatedAuthor = doc['author_name'];
        updatedCourse = doc['course_name'] ;
    } );
  }

  TextEditingController bookName = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController courseName = TextEditingController();

 

  // CollectionReference _collectionReference = FirebaseFirestore.instance.collection('books');

  Future<void >updateData(BuildContext context) async{
    await _collectionReference.doc(widget.docId).update({
      'book_name' : updatedBook,
      'author_name' :updatedAuthor,
      'course_name' : updatedCourse
    }).whenComplete((){
      print("Update Successfully Done");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Book Details',style: TextStyle(color: Colors.white,fontSize: 18.0),),
        ),
        body:  
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.book,
                    onChanged: (val){
                      updatedBook = val ;
                    },
                    // controller: bookName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Edit Book Name'),
                    validator: (input) =>
                        (input.trim().length == 0 || input.trim().length > 40)
                            ? 'Name should be less than or equal to 40 characters'
                            : null,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: widget.course,
                    onChanged: (val){
                      updatedCourse = val ;
                    },
                    // controller: courseName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Edit Course Name'),
                    validator: (input) =>
                        (input.trim().length == 0 || input.trim().length > 40)
                            ? 'Name should be less than or equal to 40 characters'
                            : null,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: widget.author,
                    // controller: authorName,
                    onChanged: (val){
                      updatedAuthor = val ;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: 'Edit Author Name'),
                    validator: (input) =>
                        (input.trim().length == 0 || input.trim().length > 40)
                            ? 'Name should be less than or equal to 40 characters'
                            : null,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        // print(updatedAuthor);
                        // print(updatedBook);
                        // print(updatedCourse);
                        if (_formKey.currentState.validate()) {
                          updateData(context);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        // padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15.0)),
                        alignment: Alignment.center,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        width: double.infinity,
                        height: 50.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
  }
}
