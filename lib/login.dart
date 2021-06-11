import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';           // new
import 'authentication.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Authentication(
        email: appState.email,
        loginState: appState.loginState,
        startLoginFlow: appState.startLoginFlow,
        verifyEmail: appState.verifyEmail,
        signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
        cancelRegistration: appState.cancelRegistration,
        registerAccount: appState.registerAccount,
        signOut: appState.signOut,
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  Future<User> currentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // Add from here // 추가하고 싶은 거 초기화하고
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String _email;
  String get email => _email;

  StreamSubscription<QuerySnapshot> _guestBookSubscription;
  List<Users> _guestBookMessages = [];
  List<Users> get guestBookMessages => _guestBookMessages;


  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void selectPosition(int position){
    // selected position save
    if(position == 0){
      print('select General person');
    }else if(position == 1){
      print('select Hiring Manager');
    }
  }

  void verifyEmail(
      String email,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      var methods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String password, String firstName, String lastName, String phone, int position,
      String nationality, String title, String level, String duty,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user.updateProfile(displayName: firstName + lastName);
      CollectionReference posts = FirebaseFirestore.instance.collection('userInfo');
      posts.add({
        'uuid': FirebaseAuth.instance.currentUser.uid,
        'FirstName': firstName,
        'LastName': lastName,
        'phoneNumber': phone,
        'position': position==0? 'General': position==1? 'Hiring Manager':'HR',
        'nationality': nationality,
        'position_title': title,
        'position_level': level,
        'duty_station': duty,
      });

    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

class Users {
  Users(
      {
        @required this.uuid,
        @required this.first_name,
        @required this.last_name,
        @required this.phone,
        @required this.position,
        @required this.nationality,
        @required this.position_title,
        @required this.position_level,
        @required this.duty_station,
        @required this.php,
        this.created,
        this.modified,
      }) :
        assert(uuid != null),
        assert(first_name != null),
        assert(last_name != null),
        assert(phone != null),
        assert(position != null),
        assert(nationality != null),
        assert(position_title != null),
        assert(position_level != null),
        assert(duty_station != null),
        assert(php != null)
  ;
  final String uuid;
  final String first_name;
  final String last_name;
  final String phone;
  final String position;
  final String nationality;
  final String position_title;
  final String position_level;
  final String duty_station;
  final String php;
  final Timestamp created;
  final Timestamp modified;
  DocumentReference reference;

  Users.fromMap(Map<String, dynamic> map, {this.reference})
  :
        assert(map['uuid'] != null),
        assert(map['first_name'] != null),
        assert(map['last_name'] != null),
        assert(map['phone'] != null),
        assert(map['position'] != null),
        assert(map['nationality'] != null),
        assert(map['position_title'] != null),
        assert(map['position_level'] != null),
        assert(map['duty_station'] != null),
        assert(map['php'] != null),
        uuid = map['uuid'],
        first_name = map['first_name'],
        last_name = map['last_name'],
        phone = map['phone'],
        position= map['position'],
        nationality= map['nationality'],
        position_title= map['position_title'],
        position_level= map['position_level'],
        duty_station= map['duty_station'],
        php= map['php'],
        created = map['created']??null,
        modified = map['modified']??null;

  Users.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data(), reference: snapshot.reference);
}