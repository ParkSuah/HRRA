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
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('offering').snapshots();
  var _isChecked = false;
  @override
  Widget build(BuildContext context) {

    // List<DocumentSnapshot> document;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          // document = snapshot.data.docs;
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            // return new ListTile(
            //   title: new Text(document.data()['firstname']),
            //   subtitle: new Text(document.data()['lastname']),
            // );
            return new DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Selected',
                    // document.data()['firstname'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Expanded(child: Text(
                    'First name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  ),
                ),
                DataColumn(
                  label: Expanded(child: Text(
                    'Last name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'Gender',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'Nationality',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'Current Position title',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'Current position level',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'Current duty station',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),
                DataColumn(
                  label: Expanded(child:Text(
                    'PHP',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
                ),

              ],
              rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(new Text(document.data()['ID'])),
                      DataCell(
                          new Checkbox(
                            value: document.data()['isSelected'],
                            onChanged: (newValue) {
                              setState(() {
                                _isChecked = document.data()['isSelected'];
                              });
                            },
                          )
                      ),
                      DataCell(Expanded(child: new Text(document.data()['firstname']))),
                      DataCell(Expanded(child:new Text(document.data()['lastname']))),
                      DataCell(Expanded(child:new Text(document.data()['gender']))),
                      DataCell(Expanded(child:new Text(document.data()['nationality']))),
                      DataCell(Expanded(child:new Text(document.data()['cu_position_title']))),
                      DataCell(Expanded(child:new Text(document.data()['cu_position_level']))),
                      DataCell(Expanded(child:new Text(document.data()['cu_position_dutystation']))),
                      DataCell(Expanded(child:new Text(document.data()['PHP']))),
                    ],
                  ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
