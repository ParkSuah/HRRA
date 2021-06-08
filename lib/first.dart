// import 'package:flutter_web/material.dart';
import 'package:flutter/material.dart';
import 'package:final_project/utils/myColors.dart';
import 'package:final_project/widgets/header.dart';
import 'package:final_project/widgets/body.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Add a container and provide a linear gradient.
    //basically use different shades of same color.
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [MyColors.white1, MyColors.white2])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[Header(), Body()],
          ),
        ),
      ),
    );
  }
}