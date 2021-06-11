import 'dart:io';

import 'package:final_project/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'authentication.dart';
import 'login.dart';
import 'offer.dart';

class ApplyPage extends StatefulWidget {
  // Offer offer;
  // ApplyPage({this.offer});
  DocumentSnapshot document;
  ApplyPage({Key key, this.document}) : super(key: key);

  @override
  _ApplyPageState createState() => _ApplyPageState(document :this.document);
}

class _ApplyPageState extends State<ApplyPage> {
  DocumentSnapshot document;
  _ApplyPageState({this.document});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>(debugLabel: '_apply');
  final _phpController = TextEditingController();
  final _IdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _currentTitleController = TextEditingController();
  final _currentLevelController = TextEditingController();
  final _currentDutyStationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 여기서 job_id 프린트 해보기
    print("received: "+document.data()['Job_Id']);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'HRRA | Jop Apply',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Builder(
                builder: (context) {
                  String uuid = Uuid().v1();
                  bool isSelected = false;
                CollectionReference posts = FirebaseFirestore.instance.collection('offering');

                Future<void> addPost() {
                  // Call the user's CollectionReference to add a new user
                  return posts
                      .add({
                    'uuid': uuid,
                    //'target_docId':
                    'isSelected' : isSelected,
                    'PHP': _phpController.text,
                    'ID': _IdController.text,
                    'firstname': _firstNameController.text,
                    'lastname': _lastNameController.text,
                    'gender': _genderController.text,
                    'nationality': _nationalityController.text,
                    'cu_position_title': _currentTitleController.text,
                    'cu_position_level': _currentLevelController.text,
                    'cu_position_dutystation': _currentDutyStationController.text,
                    'target_position': "target_position", // argument로 받은 친구
                    'created': FieldValue.serverTimestamp(),
                    'modified': FieldValue.serverTimestamp(),
                  })
                      .then((value) => print("Offering Added"))
                      .then((value) => Navigator.pop(context))
                      .catchError((error) => print("Failed to add Offering: $error"));
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
                }
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  SizedBox(height: 100,),
                  Text('Here PHP content'),
                  SizedBox(height: 50,),
                ],),
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
                            controller: _phpController,
                            decoration: const InputDecoration(
                              hintText: 'upload you PHP',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'apply PHP file to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _IdController,
                            decoration: const InputDecoration(
                              hintText: 'enter your ID',
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return 'Enter ID to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'your first name',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter first name here to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'your last name',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter last name here to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _genderController,
                            decoration: const InputDecoration(
                              hintText: 'your gender',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your gender here to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _nationalityController,
                            decoration: const InputDecoration(
                              hintText: 'your nationality',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your nationality here to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _currentTitleController,
                            decoration: const InputDecoration(
                              hintText: 'your current position title',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter current position title to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _currentLevelController,
                            decoration: const InputDecoration(
                              hintText: 'your current position level',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter current level title to continue';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _currentDutyStationController,
                            decoration: const InputDecoration(
                              hintText: 'your current position duty station',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter current position duty station to continue';
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: (){
                          //Navigator.pop(context);
                          print('Withdraw');
                          // 현재 업로드되어있는 php 회수
                        },
                        child: Text('Withdraw')),
                    SizedBox(width: 20,),
                    ElevatedButton(
                        onPressed: (){
                          print('Uploaded PHP');
                        },
                        child: Text('Uploaded PHP')),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
