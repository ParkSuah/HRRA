import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'offer.dart';

class FinalPage extends StatefulWidget {
  Offer offer;
  FinalPage({this.offer});

  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Final Decision')),
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
        // if(snapshot.data()['isSelected'] == true) {
        return new ListView(children: [
          // children: snapshot.data.docs.map((DocumentSnapshot document) {
          // return new ListTile(
          //   title: new Text(document.data()['firstname']),
          //   subtitle: new Text(document.data()['lastname']),
          // );
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Ranking',
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
            rows: _buildList(context, snapshot.data.docs),
          ),
        ]);
      },
    );
  }
  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    // bool select = snapshot.docs.data['isSelected'];
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data){
    // String current_doc = data['']
    CollectionReference posts = FirebaseFirestore.instance.collection('offering');
    bool select = data['isSelected'];
    int value = 1;
    if(select){
      print("select: " + select.toString());
      return DataRow(cells: [
        DataCell(Expanded(child: new Text('1'))),
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
    else {                //can't edit
      return DataRow(cells: [
        DataCell(
          (Expanded(child: new Text('X',
            style: new TextStyle(
              color: Colors.grey,
            ),
          ))),
        ),
        DataCell(Expanded(child: new Text(data['firstname'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['lastname'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['gender'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['nationality'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['cu_position_title'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['cu_position_level'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['cu_position_dutystation'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
        DataCell(Expanded(child: new Text(data['PHP'],
          style: new TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),))),
      ]);    }
  }
}