

import 'package:final_project/HR_view.dart';
import 'package:final_project/possibleMatching.dart';
import 'package:final_project/posting.dart';
import 'package:final_project/staff_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HManager.dart';
import 'final.dart';
import 'home.dart';
import 'login.dart';
import 'gain.dart';
import 'apply.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      title: 'Shrine',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home: HomePage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/application_offer': (context) => GainPage(),
        '/application_apply': (context) => ApplyPage(),
        '/staff_collection': (context) => StaffCollectionPage(),
        '/HR_view': (context) => HRviewPage(),
        '/HManager': (context) => HManagerPage(),
        '/posting': (context) => PostingPage(),
        '/matching': (context) => PsbMatchingPage(),
        '/final_decision': (context) => FinalPage(),
      },
      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
