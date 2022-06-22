import 'package:book_rent_app/services/crudMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';

enum BookStatus { ForSale, ForRent }

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  double _price = 0;

  BookStatus _status = BookStatus.ForSale;

  String username = "";
  String email = "";
  String userUid = "" ;

  TextEditingController bookName = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController courseName = TextEditingController();
  TextEditingController bookDesc = TextEditingController();

  String branch = "";
  String appYear = "";

  int _selectedYear = 0;
  int _selectedBranch = 0;

  bool _isVisible = true;
  bool _spinner = false;
  bool _uploading = false;

  final _formKey = GlobalKey<FormState>();
  String alert = "";
  String imageStatus = "Please upload an image";

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String defaultBookImage =
      'https://dynamicmediainstitute.org/wp-content/themes/dynamic-media-institute/imagery/default-book.png';

  String bookImage =
      'https://dynamicmediainstitute.org/wp-content/themes/dynamic-media-institute/imagery/default-book.png';

  List<DropdownMenuItem> yearList = [
    DropdownMenuItem(
      child: Text('Select year : semester'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('1st Year : 1st Semester'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('1st Year : 2nd Semester'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('2nd Year : 3rd Semester'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('2nd Year : 4th Semester'),
      value: 4,
    ),
    DropdownMenuItem(
      child: Text('3rd Year : 5th Semester'),
      value: 5,
    ),
    DropdownMenuItem(
      child: Text('3rd Year : 6th Semester'),
      value: 6,
    ),
    DropdownMenuItem(
      child: Text('4th Year : 7th Semester'),
      value: 7,
    ),
    DropdownMenuItem(
      child: Text('4th Year : 8th Semester'),
      value: 8,
    ),
  ];

  List<DropdownMenuItem> branches = [
    DropdownMenuItem(
      child: Text('Select Branch'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Computer Science and Engineering'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Communication and Computer Engineering'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('Electronics and Communication Engineering'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('Mechanical Engineering'),
      value: 4,
    ),
  ];

  List<String> allYears = [
    'dummy_data : dummy_data',
    '1st Year : 1st Semester',
    '1st Year : 2nd Semester',
    '2nd Year : 3rd Semester',
    '2nd Year : 4th Semester',
    '3rd Year : 5th Semester',
    '3rd Year : 6th Semester',
    '4th Year : 7th Semester',
    '4th Year : 8th Semester',
  ];

  List<String> allBranches = [
    'dummy_data',
    'Computer Science and Engineering',
    'Communication and Computer Engineering',
    'Electronics and Communication Engineering',
    'Mechanical Engineering'
  ];

  // FirebaseStorage.instance

  Reference storageReference = FirebaseStorage.instance.ref();

  PickedFile _image;
  // XFile _imageFile ;
  File _imgFile;

  void _getImage() async {
    final _pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // print("Path is ${_imageFile.path}");

    // PickedFile selectedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    // _imageFile = File(selectedFile.path);

    if (_pickedFile != null) {
      setState(() {
        _spinner = true;
        imageStatus = "Uploading... Please Wait";
      });

      _imgFile = File(_pickedFile.path);
      addImageToFirebase();
    }
  }

  void addImageToFirebase() async {
    String imgName = getRandomString(15);
    Reference ref = storageReference.child("bookimages/$imgName.jpg");

    TaskSnapshot uploadTask = await ref.child("image1.jpg").putFile(_imgFile);
    final downloadUrl = await uploadTask.ref.getDownloadURL();

    setState(() {
      bookImage = downloadUrl;
      imageStatus = "Image Uploaded Successfully";
      _spinner = false;
      _isVisible = false;
    });
  }

  CrudMethods _crudMethods = CrudMethods();

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((doc) {
      print('Fetching User Data');

      setState(() {
        username = doc.data()['username'];
        email = doc.data()['useremail'];
        userUid = FirebaseAuth.instance.currentUser.uid ;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _addBook() async {
    await _crudMethods
        .addBooks(userUid,username, email, bookImage, branch, bookName.text,
            courseName.text, authorName.text, bookDesc.text,appYear,_price)
        .whenComplete(() {
      bookImage = defaultBookImage;
      imageStatus = "";
      bookName.clear();
      authorName.clear();
      courseName.clear();
      bookDesc.clear();
      _price = 0 ;
      _selectedYear = 0;
      _selectedBranch = 0;
      _uploading = false;

      setState(() {
        alert = "Book Added Succesfully";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: _uploading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          child: _spinner == true
                              ? Center(child: CircularProgressIndicator())
                              : Container(),
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _isVisible
                                    ? Colors.red[700]
                                    : Colors.black),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(bookImage),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2.0,
                          right: 0.1,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {
                                _getImage();

                                setState(() {
                                  // spinner = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    imageStatus,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12.0,
                    ),
                  ),
                  // Visibility(
                  //   visible: _isVisible,
                  //   child: Text(
                  //     '',
                  //     style: TextStyle(
                  //       color: Colors.red[700],
                  //       fontSize: 12.0,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: bookName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Book Name'),
                          validator: (input) => (input.trim().length == 0 ||
                                  input.trim().length > 40)
                              ? 'Name should be less than or equal to 40 characters'
                              : null,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: courseName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Course Name'),
                          validator: (input) => (input.trim().length == 0 ||
                                  input.trim().length > 40)
                              ? 'Name should be less than or equal to 40 characters'
                              : null,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: authorName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter Author Name'),
                          validator: (input) => (input.trim().length == 0 ||
                                  input.trim().length > 40)
                              ? 'Name should be less than or equal to 40 characters'
                              : null,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: bookDesc,
                          // controller: authorName,
                          maxLines: 3,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText:
                                  'Enter Description Of Book (in 2-3 lines)'),
                          validator: (input) => (input.trim().length == 0 ||
                                  input.trim().length < 15)
                              ? 'Description should be more long. '
                              : null,
                        ),
                        SizedBox(height: 10.0),
                        DropdownButtonFormField(
                            value: _selectedYear,
                            onChanged: (val) {
                              // print(val);
                              setState(() {
                                _selectedYear = val;
                                appYear = allYears[_selectedYear];
                              });
                              print(_selectedYear);
                            },
                            items: yearList),
                        SizedBox(height: 10.0),
                        DropdownButtonFormField(
                            value: _selectedBranch,
                            onChanged: (val) {
                              setState(() {
                                _selectedBranch = val;
                                branch = allBranches[_selectedBranch];
                              });
                            },
                            items: branches),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: Text('For Sale'),
                          leading: Radio(
                            value: BookStatus.ForSale,
                            groupValue: _status,
                            onChanged: (BookStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: Text('For Rent'),
                          leading: Radio(
                            value: BookStatus.ForRent,
                            groupValue: _status,
                            onChanged: (BookStatus value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Set Price',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
                                                    Text('Price is    Rs. ${_price.toString()}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),

                          ],
                        ),
                        Slider(

                          label: '${_price.round()}',
                          divisions: 40,
                            min: 0.0,
                            max: 2000.0,
                            value: _price,
                            onChanged: (val) {
                              setState(() {
                                _price = val;
                              });
                            }),
                        SizedBox(height: 18.0),
                        Text(alert,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18.0,
                            )),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate() &&
                                bookImage != defaultBookImage) {
                              setState(() {
                                _uploading = true;
                              });
                              _addBook();
                            } else {
                              setState(() {
                                alert = "Error adding book to database";
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(15.0)),
                            alignment: Alignment.center,
                            child: Text(
                              'Publish',
                              style: TextStyle(color: Colors.white),
                            ),
                            width: double.infinity,
                            height: 50.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
