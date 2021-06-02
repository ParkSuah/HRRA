import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Widget _buildCol(BuildContext context, DocumentSnapshot data) {
  //   final Offer offer = Offer.fromSnapshot(data);
  //
  //   return ListView{
  //     scrollDirection: Axis.horizontal,
  //     children: [
  //
  //   rows: const <DataRow>(
  //       cells: <DataCell>[
  //         DataCell(Text('12345')),
  //         // DataCell(Text(offer.ID)),
  //         DataCell(Text('Suah')),
  //         DataCell(Text('Park')),
  //         DataCell(Text('F')),
  //         DataCell(Text('USA')),
  //         DataCell(Text('Position1')),
  //         DataCell(Text('2')),
  //         DataCell(Text('LA')),
  //         DataCell(Text('12345.pdf')),
  //       ],
  //     )
  //   },
  // },
  // }

}

class MyStatelessWidget extends StatelessWidget {
  Offer offer;
  MyStatelessWidget({this.offer});
//
//   @override
//   State<StatefulWidget> createState() => MyStateWidgetState();
// }
//
// class MyStateWidgetState extends State<MyStateWidget>{
  // const MyStateWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference offers = FirebaseFirestore.instance.collection('offering');
    return  ListView(
      scrollDirection: Axis.horizontal,
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'ID#',
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

            // return FutureBuilder<DocumentSnapshot>(
            //   future: offers.doc(offers.id).get(),
            //   builder:
            //   (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //   if (snapshot.hasError) {
            //   return Text("Something went wrong");
            //   }
            //
            //   if (snapshot.hasData && !snapshot.data.exists) {
            //   return Text("Document does not exist");
            //   }
            //
            //   if (snapshot.connectionState == ConnectionState.done) {
            //   Map<String, dynamic> data = snapshot.data.data();
            //   return Text("Full Name: ${data['firstname']} ${data['lastname']}");
            //   }
            //
            //   return Text("loading");
            //   },
            // );

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
  }
}
