import 'dart:io';

import 'package:final_project/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'authentication.dart';
import 'login.dart';

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text(
            'HRRA | Staff Collection',
            style: TextStyle(color: Colors.white),
          ),
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
                              hintText: 'nationality?',
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
                              hintText: 'current position title?',
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
                              hintText: 'current position level?',
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
                              hintText: 'current duty station?',
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
                              hintText: 'PHP?',
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

class ImagePickerWidget extends StatefulWidget{
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget>{
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        print('No image selected (default here)');
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          _image == null
              ? Image.network('http://handong.edu/site/handong/res/img/logo.png', height: 149)
              : Image.file(_image, height: 149,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: getImage,
              ),
            ],
          ),
          Text(
              'Product Name',
              style: TextStyle(fontSize: 15, fontWeight:FontWeight.w500, color: Colors.blueAccent)
          ),
          Divider(
            height: 10,
            thickness: 1,
            indent: 40,
            endIndent: 40,
            color: Colors.blue,
          ),
        ],
    );
  }
}