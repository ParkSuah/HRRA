import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/components/components.dart';

// TODO Replace with object model.
const String listItemTitleText = "Job Offer";
const String listItemPreviewText =
      "You can display your job and find new person for your job position.";
const String listItemTitleText3 = "HR View";
const String listItemPreviewText3 =
    "Human Relocation View";
const String listItemTitleText5 = "Possible Matching";
const String listItemPreviewText5 =
    "AI will match the best position";
const String listItemTitleText2 = "Job Apply";
const String listItemPreviewText2 =
    "You can apply your interested job here.";
const String listItemTitleText4 = "Hiring Manager";
const String listItemPreviewText4 =
    "Hiring Manager View";

class ListPage extends StatelessWidget {
  final Stream<QuerySnapshot> _userInfoStream =
  FirebaseFirestore.instance.collection('userInfo').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _userInfoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('Loading...');
      }
      // if (_position(context, snapshot.data.docs) == 'HR'){
      if (_position(context, snapshot.data.docs) == 'HR'){
        return Scaffold(
          body:
          Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      MenuBar(),
                      ListItem3(
                          title: listItemTitleText3,
                          description: listItemPreviewText3),
                      divider,
                      ListItem5(
                          title: listItemTitleText5,
                          description: listItemPreviewText5),
                      divider,
                      Footer(),
                    ],
                  ),
                ),
              ),
            ],
            // },

          ),
          backgroundColor: Colors.white,
        );
      }
      if (_position(context, snapshot.data.docs) == 'Hiring Manager'){
        return Scaffold(
          body:
          Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      MenuBar(),
                      ListItem4(
                          title: listItemTitleText4,
                          description: listItemPreviewText4),
                      divider,
                      ListItem5(
                          title: listItemTitleText5,
                          description: listItemPreviewText5),
                      divider,
                      Footer(),
                    ],
                  ),
                ),
              ),
            ],
            // },

          ),
          backgroundColor: Colors.white,
        );
      }
      else {
        return Scaffold(
          body:
          Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      MenuBar(),
                      ListItem(
                          title: listItemTitleText,
                          description: listItemPreviewText),
                      divider,
                      ListItem2(
                          title: listItemTitleText2,
                          description: listItemPreviewText2),
                      divider,
                      ListItem5(
                          title: listItemTitleText5,
                          description: listItemPreviewText5),
                      divider,
                      Footer(),
                    ],
                  ),
                ),
              ),
            ],
            // },

          ),
          backgroundColor: Colors.white,
        );
      }
    });
  }

  String _position(BuildContext context, List<DocumentSnapshot> snapshot){
    String pos;
    String nullpos;
    snapshot.map((data){
      if(data['uuid'] == FirebaseAuth.instance.currentUser.uid){
        pos = data['position'];
      }else{
        nullpos = "No Position Loaded";
        print(nullpos);
      }
    }).toList();
    return pos;
  }
}