import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/apply.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class PostingPage extends StatefulWidget {
  @override
  _PostingPageState createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
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
                                  String arg = document.data()['Job_Id'];//document.id;//
                                  print("send: "+arg);
                                  // print("Job_id: "+document.data()['Job_Id']);
                                  // print("doc_id: "+document.id);
                                  // Navigator.pushNamed(context, '/application_apply', arguments: document);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyPage(document: document)));
                                },
                                    child: Text("Apply")),
                                    SizedBox(width: 10,),
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
      appBar: AppBar(title: Text('Posting')),
      body: Container(child: _buildBody(context)),
    );
  }
}
