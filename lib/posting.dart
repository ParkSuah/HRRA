import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class PostingPage extends StatefulWidget {
  Offer offer;
  PostingPage({this.offer});

  @override
  _PostingPageState createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posting').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['title']),
              subtitle: new Text(document.data()['level']),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posting')),
      body: Container(child: _buildBody(context)),
    );
  }
}
