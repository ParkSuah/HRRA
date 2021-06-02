import 'package:final_project/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'offer.dart'; // data model

import 'authentication.dart';
import 'login.dart';

class GainPage extends StatefulWidget {
  Apply apply_data;
  GainPage({this.apply_data});

  @override
  _GainPageState createState() => _GainPageState();
}

class _GainPageState extends State<GainPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>(debugLabel: '_gain');
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _levelController = new TextEditingController();
  final TextEditingController _postController = new TextEditingController();
  final TextEditingController _divisionController = new TextEditingController();
  final TextEditingController _branchController = new TextEditingController();
  final TextEditingController _dutyStationController =
      new TextEditingController();
  // String tempID = Uuid().v1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text(
            'HRRA | application',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Builder(builder: (context) {
              String uuid = Uuid().v1();
              CollectionReference posts =
                  FirebaseFirestore.instance.collection('posting');

              Future<void> addPost() {
                // Call the user's CollectionReference to add a new user
                return posts
                    .add({
                      'uuid': uuid,
                      'Title': _titleController.text,
                      'Level': int.parse(_levelController.text),
                      'Post': _postController.text,
                      'Division': _divisionController.text,
                      'Branch': _branchController.text,
                      'Duty': _dutyStationController.text,

                      // 'uid': Users.id,
                      'likes': 0,
                      'created': FieldValue.serverTimestamp(),
                      'modified': FieldValue.serverTimestamp(),
                    })
                    .then((value) => print("Post Added"))
                    .then((value) => Navigator.pop(context))
                    .catchError((error) => print("Failed to add post: $error"));
              }

              // return TextButton(
              //   child: Text("save", style: TextStyle(fontSize: 20.0, color: Colors.white),),
              //   onPressed: () async {
              return IconButton(
                onPressed: addPost,
                icon: Icon(Icons.add),
                iconSize: 30,
              );
              // },
              // );
            })
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                            controller: _titleController,
                            decoration: const InputDecoration(
                              //hintText: 'Title',
                              hintText: 'Title',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter title to continue';
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
                              hintText: 'Level',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return 'Enter level to continue';
                              } else if (value != '1' ||
                                  value != '2' ||
                                  value != '3' ||
                                  value != '4' ||
                                  value != '5') {
                                return 'Enter proper level (1-5)';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _postController,
                            decoration: const InputDecoration(
                              hintText: 'Post',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter post to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _divisionController,
                            decoration: const InputDecoration(
                              hintText: 'Division',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter division to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _branchController,
                            decoration: const InputDecoration(
                              hintText: 'Branch',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter branch to continue';
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
                              hintText: 'Duty',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter duty station to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL')),
                    SizedBox(
                      width: 20,
                    ),
                    // TextButton(
                    //     onPressed: (){
                    //       print('save');
                    //
                    //     },
                    //     child: Text('SAVE')),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
