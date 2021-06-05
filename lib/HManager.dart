import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class HManagerPage extends StatefulWidget {
  Offer offer;
  HManagerPage({this.offer});

  @override
  _HManagerPageState createState() => _HManagerPageState();
}

class _HManagerPageState extends State<HManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hiring Manager View')),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('offering').snapshots();
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
    );
  }

  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
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