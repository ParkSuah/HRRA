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
      body: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  // Offer offer;
  // MyStatelessWidget({this.offer});

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('offering').snapshots();

  @override
  Widget build(BuildContext context) {
    // List<DocumentSnapshot> list;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                    'ID#',
                    // document.data()['firstname'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'First name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Last name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Gender',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Nationality',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Current Position title',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Current position level',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Current duty station',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'PHP',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(new Text(document.data()['ID'])),
                    DataCell(new Text(document.data()['firstname'])),
                    DataCell(new Text(document.data()['lastname'])),
                    DataCell(new Text(document.data()['gender'])),
                    DataCell(new Text(document.data()['nationality'])),
                    DataCell(new Text(document.data()['cu_position_title'])),
                    DataCell(new Text(document.data()['cu_position_level'])),
                    DataCell(new Text(document.data()['cu_position_dutystation'])),
                    DataCell(new Text(document.data()['PHP'])),
                  ],
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  /*
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: [
        DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'ID#',
                // document.data()['firstname'],
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'First name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Last name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Gender',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Nationality',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Current Position title',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Current position level',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Current duty station',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'PHP',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],

          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('12345')),
                // DataCell(Text(offer.ID)),
                DataCell(Text('Suah')),
                DataCell(Text('Park')),
                DataCell(Text('F')),
                DataCell(Text('USA')),
                DataCell(Text('Position1')),
                DataCell(Text('2')),
                DataCell(Text('LA')),
                DataCell(Text('12345.pdf')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('12346')),
                DataCell(Text('Mark')),
                DataCell(Text('Lee')),
                DataCell(Text('M')),
                DataCell(Text('Canada')),
                DataCell(Text('Position3')),
                DataCell(Text('3')),
                DataCell(Text('Vancouver')),
                DataCell(Text('12346.pdf')),
              ],
            ),
          ],
        ),
      ],
    );
  }*/
}
