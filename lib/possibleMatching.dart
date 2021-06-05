import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/apply.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class PsbMatchingPage extends StatefulWidget {
  Offer offer;
  PsbMatchingPage({this.offer});

  @override
  _PsbMatchingPageState createState() => _PsbMatchingPageState();
}

class _PsbMatchingPageState extends State<PsbMatchingPage> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posting').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return new GridView.count(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 5,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new Expanded(
              child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  child: Container(
                    width: 200,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Text("Title   "+document.data()['Title'])),
                        Expanded(child: Text("Level   "+document.data()['Level'].toString())),
                        Expanded(child: Text("Post    "+document.data()['Post'] )),
                        Expanded(child: Text("Division  "+document.data()['Division'])),
                        Expanded(child: Text("Branch  "+document.data()['Branch'])),
                        Expanded(child: Text("Duty station  "+document.data()['Duty'])),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              print("Final Decision button pressed");
                              Navigator.pushNamed(context, '/final_decision');
                            },
                              child: Expanded(child: Text("Final Decision")),),
                            Expanded(flex: 5, child: SizedBox(width: 50,)),
                          ],
                        ),)
                      ],
                    ),
                  )
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Possible Matching')),
      body: Container(child: _buildBody(context)),
    );
  }
}
