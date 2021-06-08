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
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/staff_collection');
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          ),
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
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.lime,
                              minimumSize: Size(200, 200),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/application_offer');
                            },
                            child: Text('Job Offer')),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("You can display your job and find \nnew person for your job position.", textAlign: TextAlign.justify),
                  ]),
              /*
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lime,
                          minimumSize: Size(200, 200),
                        ),
                        onPressed: () {

                          Navigator.pushNamed(context, '/application_apply');
                        },
                        child: Text('Job Apply'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Text('AA'),
                ],
              ),
               */
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lime,
                          minimumSize: Size(200, 200),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/HR_view');
                        },
                        child: Text('HR View'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Text("dd"),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      // 만약 현재 유저가 HM 라면 보여지는 버튼으로 구현
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lime,
                          minimumSize: Size(200, 200),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/matching');
                        },
                        child: Text('Possible Matching'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  )
                ],
              ),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         // ElevatedButton(
              //         //   style: TextButton.styleFrom(
              //         //     backgroundColor: Colors.lime,
              //         //     minimumSize: Size(200, 200),
              //         //   ),
              //         //   onPressed: () {
              //         //     Navigator.pushNamed(context, '/staff_collection');
              //         //   },
              //         //   child: Text('Staff Info'),
              //         // ),
              //         // SizedBox(
              //         //   width: 30,
              //         // ),
              //       ],
              //     )
              //   ],
              // ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lime,
                          minimumSize: Size(200, 200),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/posting');
                        },
                        child: Text('Job Apply'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Text("dd"),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lime,
                          minimumSize: Size(200, 200),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/HManager');
                        },
                        child: Text('Hiring Manager'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Text("dd")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
