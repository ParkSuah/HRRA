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
        //selectPosition: appState
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

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('userList')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          snapshot.docs.forEach((document) {
            _guestBookMessages.add(
              Users(
                first_name: document.data()['firstName'],
                last_name: document.data()['lastName'],
                id: document.data()['userId'],
                phone: document.data()['phone'],
                date: DateTime.fromMillisecondsSinceEpoch(
                    document.data()['timestamp']),
                doc_id: document.id,
              ),
            );
          });
          notifyListeners();
        });
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
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user.updateProfile(displayName: firstName + lastName);
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
        @required this.first_name,
        @required this.last_name,
        @required this.id,
        @required this.phone,
        @required this.date,
        @required this.position,
        @required this.doc_id});
  final String first_name;
  final String last_name;
  final String id;
  final String phone;
  final DateTime date;
  final int position;
  final String doc_id;
}

/*
class UserList extends StatefulWidget {
  UserList(
      {
        @required this.addMessage,
        @required this.deleteMessage,
        @required this.messages});
  final FutureOr<void> Function(String message) addMessage;
  final FutureOr<void> Function(String message_id) deleteMessage;
  final List<UserList> messages;

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<UserList> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String current_id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        for (var message in widget.messages)
          Row(
            children: [
              SizedBox(width: 8),
              Container(
                constraints: BoxConstraints(maxWidth: 350, minWidth: 350),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Paragraph('${message.name}: ${message.message}'),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        message.date != null
                            ? Text('${message.date}')
                            : Paragraph('no id'), // date 들어가면 될듯
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // current_id == message.id?
              FirebaseAuth.instance.currentUser!.uid.compareTo(message.id) == 0
                  ? IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () async {
                    await widget.deleteMessage(message.doc_id);
                  })
                  : SizedBox(width: 0)
            ],
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
 */