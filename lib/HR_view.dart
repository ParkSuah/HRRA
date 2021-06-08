import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class HRviewPage extends StatefulWidget {
  Offer offer;
  HRviewPage({this.offer});

  @override
  _HRviewPageState createState() => _HRviewPageState();
}

class _HRviewPageState extends State<HRviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HR View')),
      body: HRCardPage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  DocumentSnapshot document;
  DataTablePage({Key key, this.document}) : super(key: key);

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  DocumentSnapshot document;
  _DataTablePageState({this.document});
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('offering').snapshots();
  var _isChecked = false;
  @override
  Widget build(BuildContext context) {
    // List<DocumentSnapshot> document;
    print("Build table");
    return Scaffold(
      appBar: AppBar(title: Text("Tabler"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // document = snapshot.data.docs;
            return Text("Loading");
          }

          return new ListView(children: [
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Selected',
                    // document.data()['firstname'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'First name',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Last name',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Gender',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Nationality',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Current Position title',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Current position level',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Current duty station',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'PHP',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: _buildList(context, snapshot.data.docs),
            ),
          ]);
        },
      ),
    );
  }

  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    //return snapshot.map((data)=> data.data()['Job_Id']==document.data()['Job_Id']? _buildListItem(context, data):_buildListItem(context, data)).toList();
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data){
    // String current_doc = data['']
    CollectionReference posts = FirebaseFirestore.instance.collection('offering');
    return DataRow(cells: [
      DataCell(
          new Checkbox(
            value: data['isSelected'],
            onChanged: (bool newValue) {
              setState(() {
                final uuid = data.id;
                // _isChecked = data['isSelected'];
                posts.doc(uuid).update({
                  'isSelected': newValue,
                });
                // data['isSelected'] = newValue;
              });
            },
          )
      ),
      DataCell(Expanded(child: new Text(data['firstname']))),
      DataCell(Expanded(child: new Text(data['lastname']))),
      DataCell(Expanded(child: new Text(data['gender']))),
      DataCell(Expanded(child: new Text(data['nationality']))),
      DataCell(Expanded(child: new Text(data['cu_position_title']))),
      DataCell(Expanded(child: new Text(data['cu_position_level']))),
      DataCell(Expanded(child: new Text(data['cu_position_dutystation']))),
      DataCell(Expanded(child: new Text(data['PHP']))),
    ]);
  }
}
class HRCardPage extends StatefulWidget {
  @override
  _HRCardPageState createState() => _HRCardPageState();
}
class _HRCardPageState extends State<HRCardPage> {
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
                              //Navigator.pushNamed(context, '/data_table'/*, arguments: arg*/);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DataTablePage(document: document)));
                            },
                                child: Text("Show")),
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
    return _buildBody(context);//Container(child: _buildBody(context));
  }
}