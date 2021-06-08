import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';

class PositionPage extends StatefulWidget {
  @override
  _PositionState createState() => _PositionState();
}

// grid 얘를 위한 위젯을 따로 ?
class _PositionState extends State<PositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Select your Position'),
      ),
      body:Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async{
                      FirebaseAuth.instance.currentUser;
                },
                    child: Text('General'))
              ],
            ),
          )
    );
  }
}