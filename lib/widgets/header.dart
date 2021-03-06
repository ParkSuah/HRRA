import 'package:flutter/material.dart';
import 'package:final_project/utils/myColors.dart';
import 'package:final_project/utils/strings.dart';
import 'package:final_project/utils/responsive_widget.dart';
import 'package:final_project/router.dart' as router;
import '../utils/display_util.dart';
import 'dart:html' as html;

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var links = ["Home", "Github"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: buildHeader(context),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[buildLogo(context), buildHeaderLinks(context)],
    );
  }

  //Builds navigation links at the right top of landing page
  Widget buildHeaderLinks(BuildContext context) {
    if (!ResponsiveWidget.isSmallScreen(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: getLinksListing(context)..add(buildLoginButton(context)),
      );
    } else {
      return PopupMenuButton(
        //child: Image.network("assets/menu.png", width: 25, height: 25),
        child: Image.asset("images/menu.png", width: 25, height: 25),
        onSelected: (NavLinks value) {
          setState(() {
            openLink(value);
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<NavLinks>>[
          const PopupMenuItem(value: NavLinks.Home, child: Text("Home")),
          const PopupMenuItem(value: NavLinks.Github, child: Text("Github")),
          // const PopupMenuItem(value: NavLinks.Videos, child: Text("Videos")),
          // const PopupMenuItem(value: NavLinks.Jobs, child: Text("Jobs")),
          // PopupMenuItem(value: NavLinks.Login, child: buildLoginButton(context))
        ],
      );
    }
  }

  bool isNotNavLinksLogin(link) {
    return link != NavLinks.LogIn;
  }

  //Builds navigation list for header
  List<Widget> getLinksListing(BuildContext context) {
    return NavLinks.values.where((link) => link != NavLinks.LogIn).map((link) {
      return Padding(
          padding: EdgeInsets.only(left: 18),
          child: InkWell(
              hoverColor: Theme.of(context).primaryColor,
              highlightColor: Theme.of(context).secondaryHeaderColor,
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              child: Text(
                displayString(link),
                style: Theme.of(context).textTheme.title,
                //style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                openLink(link);
              }));
    }).toList();
  }

  void openLink(NavLinks link) {
    if (link == NavLinks.Resources) {
      //open Resource page
      // Navigator.pushNamed(context, router.FLUTTER_RESOURCES);
    } else {
      html.window.open(getTargetUrl(link), displayString(link));
    }
  }

  String getTargetUrl(NavLinks link) {
    String url = "";

    switch (link) {
      case NavLinks.Home:
        url = "https://www.un.org/en/";
        break;

      case NavLinks.Github:
        url = "https://github.com/ParkSuah/HRRA";
        break;

      case NavLinks.Videos:
        // url = "https://www.youtube.com/channel/UCO3_dbHasEnA2dr_U0EhMAA/videos?view_as=subscriber";
        break;

      case NavLinks.Jobs:
        // url = "https://flutterjobs.info";
        break;

      default:
        // url = "https://flutter-to-fly.firebaseapp.com";
    }
    print("url: " + url);
    return url;
  }

  //Builds and decorates login button
  Widget buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Container(
          margin: EdgeInsets.only(left: 20),
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).secondaryHeaderColor
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).accentColor.withOpacity(0.3),
                    offset: Offset(0, 8), //Shadow starts at x=0, y=8
                    blurRadius: 8)
              ]),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                Strings.loginButton,
                style: TextStyle(
                    color: MyColors.white1, fontSize: 18, letterSpacing: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Builds rectangle with circular corners and Text on it and next to it as title
  Widget buildLogo(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
          child: Center(
            child: Image.asset('images/un.png'),
          ),
        ),
        //give some space between logo box and title
        SizedBox(
          width: 16,
        ),
        Text(
          Strings.appTitle,
          style: TextStyle(fontSize: 26),
        )
      ],
    );
  }
}