import 'dart:io';

import 'package:final_project/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'authentication.dart';
import 'login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String DOCid = '';

class StaffCollectionPage extends StatefulWidget {
  @override
  _StaffCollectionPageState createState() => _StaffCollectionPageState();
}

class _StaffCollectionPageState extends State<StaffCollectionPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_apply');
  final _nationlityController = TextEditingController();
  final _levelController = TextEditingController();
  final _PHPController = TextEditingController();
  final _titleController = TextEditingController();
  final _dutyStationController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future getDocID() async{
      print("Im in getDocID");
    }

    // Future<void> updatePost({@required String docId}) async{
    //   Query doc_ID = FirebaseFirestore.instance.collection('userInfo').where('uuid', isEqualTo: FirebaseAuth.instance.currentUser.uid);
    //   DocumentReference posts = FirebaseFirestore.instance.collection('userInfo').doc(docId);
    //   Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection('userInfo').snapshots();
    //
    //
    //   return await posts
    //       .update({
    //     'nationality': _nationlityController.text,
    //     'position_title': _titleController.text,
    //     'position_level': _levelController.text,
    //     'duty_station': _dutyStationController.text,
    //     'PHP': _PHPController.text,
    //   })
    //       .then((value) => print("UserInfo Updated"))
    //       .then((value) => Navigator.pop(context))
    //       .catchError((error) => print("Failed to update your information: $error"));
    // }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text(
            'HRRA | Staff Collection',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: getDocID,
            ),
            SizedBox(width: 10,),
          ]
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImagePickerWidget(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _nationlityController,
                            decoration: const InputDecoration(
                              hintText: 'Your Nationality',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'enter your nationality';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Your Current position title',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return 'Enter current position title to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _levelController,
                            decoration: const InputDecoration(
                              hintText: 'Your current position level',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return 'Enter current position level to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _dutyStationController,
                            decoration: const InputDecoration(
                              hintText: 'Your current duty station',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return 'Enter current duty station to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _PHPController,
                            decoration: const InputDecoration(
                              hintText: 'Your PHP',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your PHP here to continue';
                              } // 없앨까 조건
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          //Navigator.pop(context);
                          print('Withdraw');
                          // 현재 업로드되어있는 php 회수
                        },
                        child: Text('Withdraw')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print('Uploaded PHP');
                        },
                        child: Text('Uploaded PHP')),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class ImagePickerWidget extends StatefulWidget {
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  Image _image;
  final picker = ImagePickerWeb; //?

  Future getImage() async {
    final pickedFile = await ImagePickerWeb.getImage(outputType: ImageType.widget);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile; // File(pickedFile.path);
      } else {
        print('No image selected (default here)');
      }
    });
  }

  final Stream<QuerySnapshot> _userInfoStream =
      FirebaseFirestore.instance.collection('userInfo').snapshots();
  @override
  Widget build(BuildContext context) {
    // FirebaseProvider
    return StreamBuilder<QuerySnapshot>(
        stream: _userInfoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return new Column(children: [
            Column(children: [
              _image == null
                  ? Image.network(
                      'https://i1.wp.com/blogs.un.org/wp-content/uploads/2015/10/LOGO2.jpg',
                      height: 149)
                  : Container(
                height: 149,
                child: _image,
              )//Image.file(
                      //_image,
                      //height: 149,
                    //)
              ,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: getImage,
                  ),
                ],
              ),
              new Text(_position(context, snapshot.data.docs),
                  // Text(auth.currentUser.uid),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
              new Text(_username(context, snapshot.data.docs),
                  // Text(auth.currentUser.uid),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent)),

              Divider(
                height: 10,
                thickness: 1,
                indent: 40,
                endIndent: 40,
                color: Colors.blue,
              ),
            ]),
          ]);
        });
  }
  String _username(BuildContext context, List<DocumentSnapshot> snapshot){
    String realName ;
    String nullName ;
    snapshot.map((data){
      if(data['uuid'] == FirebaseAuth.instance.currentUser.uid){
        realName = data['FirstName']+' '+data['LastName'];
      }else{
        nullName = "No Name Loaded";
      }
    }).toList();
    return realName;
  }
  String _position(BuildContext context, List<DocumentSnapshot> snapshot){
    String pos;
    String nullpos;
    snapshot.map((data){
      if(data['uuid'] == FirebaseAuth.instance.currentUser.uid){
        pos = data['position'];
      }else{
        nullpos = "No Position Loaded";
      }
    }).toList();
    return pos;
  }

  String _phoneNum(BuildContext context, List<DocumentSnapshot> snapshot){
    String phoneNum ;
    String nullNum ;
    snapshot.map((data){
      if(data['uuid'] == FirebaseAuth.instance.currentUser.uid){
        phoneNum = data['FirstName']+' '+data['LastName'];
      }else{
        nullNum = "No Name Loaded";
      }
    }).toList();
    return phoneNum;
  }
}
