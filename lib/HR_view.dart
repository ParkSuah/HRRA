import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HRviewPage extends StatefulWidget {
  @override
  _HRviewPageState createState() => _HRviewPageState();
}

class _HRviewPageState extends State<HRviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HR View')),
      body: const MyStatelessWidget(),
    );
  }
}
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('12345')),
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
