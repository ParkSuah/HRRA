

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
import 'first.dart';
import 'home.dart';
import 'login.dart';
import 'gain.dart';
import 'apply.dart';
import 'login_web/login_page.dart';
import 'login_web/start_profile.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, firebaseUser) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  User get user => null;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      title: 'final_project',
      home: HomePage(),
      initialRoute: '/first',
      routes: {
        '/first': (context) =>FirstPage(),
        '/login': (context) => LoginPage(),
        // '/user_profile': (context) => UserProfilePage(context, user),
        // '/login': (context) => LogInPage(),
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
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/first') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => FirstPage(),
      fullscreenDialog: true,
    );
  }
}
