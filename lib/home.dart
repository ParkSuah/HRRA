import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'login.dart';

/*
fontSize: 20,
fontWeight: FontWeight.w500,
*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// grid 얘를 위한 위젯을 따로 ?
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                          minimumSize: Size(200, 100),
                        ),
                     onPressed: () {
                          Navigator.pushNamed(context, '/application_offer');
                        },
                        child: Text('Job Offer')),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                        minimumSize: Size(200, 100),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/application_apply');
                      },
                      child: Text('Job Apply'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent,
                        minimumSize: Size(200, 100),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/HR_view');
                      },
                      child: Text('HR View'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 만약 현재 유저가 HM 라면 보여지는 버튼으로 구현
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                        minimumSize: Size(200, 100),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/matching');
                      },
                      child: Text('Possible Matching'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                        minimumSize: Size(200, 100),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/staff_collection');
                      },
                      child: Text('Staff Info'),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}