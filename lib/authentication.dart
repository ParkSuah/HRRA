import 'package:final_project/home.dart';
import 'package:flutter/material.dart';

import 'home/page_list.dart';
import 'widgets.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    @required this.loginState,
    @required this.email,
    @required this.startLoginFlow,
    @required this.verifyEmail,
    @required this.signInWithEmailAndPassword,
    @required this.cancelRegistration,
    @required this.registerAccount,
    @required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
    int position,
    String nationality,
    String title,
    String level,
    String duty,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: Text("Login Page"),
          ),
          body:
          ListView(
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        startLoginFlow();
                      },
                      child: Text('          LOGIN          '),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case ApplicationLoginState.emailAddress:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: Text("**"),
          ),
          body: ListView(
            children: [
              EmailForm(
                  callback: (email) => verifyEmail(email,
                      (e) => _showErrorDialog(context, 'Invalid email', e))),
            ],
          ),
        );
      case ApplicationLoginState.password:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: Text("****"),
          ),
          body: ListView(
            children: [
              PasswordForm(
                email: email,
                login: (email, password) {
                  signInWithEmailAndPassword(email, password,
                      (e) => _showErrorDialog(context, 'Failed to sign in', e));
                },
              ),
            ],
          ),
        );
      case ApplicationLoginState.register:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: Text("******"),
          ),
          body: ListView(
            children: [
              RegisterForm(
                email: email,
                cancel: () {
                  cancelRegistration();
                },
                registerAccount: (
                  email,
                  password,
                  firstName,
                  lastName,
                  phone,
                  position,
                  nationality,
                  position_title,
                  position_level,
                  duty_station,
                ) {
                  registerAccount(
                      email,
                      password,
                      firstName,
                      lastName,
                      phone,
                      position,
                      nationality,
                      position_title,
                      position_level,
                      duty_station,
                      (e) => _showErrorDialog(
                          context, 'Failed to create account', e));
                },
              ),
            ],
          ),
        );
      case ApplicationLoginState.loggedIn:
        // return HomePage();
      return ListPage();
      default:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white24,
            title: Text("************"),
          ),
          body: ListView(
            children: [
              Row(
                children: [
                  Text("Internal error, this shouldn't happen..."),
                ],
              ),
            ],
          ),
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmailForm extends StatefulWidget {
  EmailForm({@required this.callback});
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header('Sign in with email'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: Text('NEXT'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm({
    @required this.registerAccount,
    @required this.cancel,
    @required this.email,
  });
  final String email;
  final void Function(String email, String password, String firstName, String lastName, String phone, int position,
                      String nationality, String position_title, String position_level, String duty_station)
      registerAccount;
  final void Function() cancel;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _positionTitleController = TextEditingController();
  final _positionLevelController = TextEditingController();
  final _dutyStationController = TextEditingController();
  int selected_position;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header('Create account'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: 'First name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: 'Last name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        TextButton(
                          child: Text('General'),
                          onPressed: (){
                            selected_position = 0;
                            print('General');
                            // 선택된 버튼은 표시
                          },
                        ),
                        SizedBox(width: 20,),
                        TextButton(
                          child: Text('Hiring Manager'),
                          onPressed: (){
                            selected_position = 1;
                            print('Hiring Manager');
                            // 선택된 버튼은 표시
                          },
                        ),
                        SizedBox(width: 20,),
                        TextButton(
                          child: Text('HR'),
                          onPressed: (){
                            selected_position = 2;
                            print('HR');
                            // 선택된 버튼은 표시
                          },
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _nationalityController,
                    decoration: const InputDecoration(
                      hintText: 'Nationality',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your nationality';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _positionTitleController,
                    decoration: const InputDecoration(
                      hintText: 'Position Title',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your current position title';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _positionLevelController,
                    decoration: const InputDecoration(
                      hintText: 'Position Level',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your current position level';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _dutyStationController,
                    decoration: const InputDecoration(
                      hintText: 'Duty Station',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your current duty station';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: widget.cancel,
                        child: Text('CANCEL'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            widget.registerAccount(
                              _emailController.text,
                              _passwordController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _phoneController.text,
                              selected_position,
                              _nationalityController.text,
                              _positionTitleController.text,
                              _positionLevelController.text,
                              _dutyStationController.text,
                            );
                          }
                        },
                        child: Text('SAVE'),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  PasswordForm({
    @required this.login,
    @required this.email,
  });
  final String email;
  final void Function(String email, String password) login;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header('Sign in'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 16),
                      StyledButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: Text('SIGN IN'),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
