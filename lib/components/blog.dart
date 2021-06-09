import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/components/color.dart';
import 'package:final_project/components/spacing.dart';
import 'package:final_project/components/text.dart';
import 'package:final_project/components/typography.dart';

import '../routes.dart';
// import 'package:final_project/routes.dart';

class ImageWrapper extends StatelessWidget {
  final String image;

  const ImageWrapper({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Listen to inherited widget width updates.
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image,
        width: width,
        height: width / 1.618,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TagWrapper extends StatelessWidget {
  final List<Tag> tags;

  const TagWrapper({Key key, this.tags = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: paddingBottom24,
        child: Wrap(
          spacing: 8,
          runSpacing: 0,
          children: <Widget>[...tags],
        ));
  }
}

class Tag extends StatelessWidget {
  final String tag;

  const Tag({Key key, @required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      child: Text(
        tag,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
      fillColor: Color(0xFF242424),
      padding: EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      hoverElevation: 0,
      hoverColor: Color(0xFFC7C7C7),
      highlightElevation: 0,
      focusElevation: 0,
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  final Function onPressed;

  const ReadMoreButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hover = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MouseRegion(
            onHover: (event) => setState(() => hover = true),
            onExit: (event) => setState(() => hover = false),
            child: OutlineButton(
              onPressed: onPressed as void Function(),
              highlightedBorderColor: textPrimary,
              hoverColor: textPrimary,
              borderSide: BorderSide(color: textPrimary, width: 2),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Click Here",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: hover ? Colors.white : textPrimary,
                      letterSpacing: 1),
                ),
              ),
            ),
          );
        });
  }
}

const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);
Widget dividerSmall = Container(
  width: 40,
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA0A0A0),
        width: 1,
      ),
    ),
  ),
);

List<Widget> authorSection(
    {@required String imageUrl, String name, String bio}) {
  return [
    divider,
    Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: <Widget>[
          if (imageUrl != null)
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (name != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextHeadlineSecondary(text: name),
                  ),
                if (bio != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bio,
                      style: bodyTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    divider,
  ];
}

class Footer extends StatelessWidget {
  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextBody(text: "Copyright © 2021"),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String description;

  const ListItem(
      {Key key, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.offer),
            ),
          ),
        ),
      ],
    );
  }
}

class ListItem2 extends StatelessWidget {
  final String title;
  final String description;

  const ListItem2(
      {Key key, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.apply),
            ),
          ),
        ),
      ],
    );
  }
}

class ListItem3 extends StatelessWidget {
  final String title;
  final String description;

  const ListItem3(
      {Key key, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.HR),
            ),
          ),
        ),
      ],
    );
  }
}

class ListItem4 extends StatelessWidget {
  final String title;
  final String description;

  const ListItem4(
      {Key key, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.HM),
            ),
          ),
        ),
      ],
    );
  }
}

class ListItem5 extends StatelessWidget {
  final String title;
  final String description;

  const ListItem5(
      {Key key, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(
              onPressed: () => Navigator.pushNamed(context, Routes.PMat),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Menu/Navigation Bar
 *
 * A top menu bar with a text or image logo and
 * navigation links. Navigation links collapse into
 * a hamburger menu on screens smaller than 400px.
 */
class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text("HRRA",
                    style: GoogleFonts.montserrat(
                        color: textPrimary,
                        fontSize: 30,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500)),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pushNamed(context, '/first'),
                        child: Text(
                          "MAIN",
                          style: buttonTextStyle,
                        ),
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      FlatButton(
                        onPressed: () => Navigator.pushNamed(context, '/staff_collection'),
                        child: Text(
                          "PROFILE",
                          style: buttonTextStyle,
                        ),
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 1,
            margin: EdgeInsets.only(bottom: 30),
            color: Color(0xFFEEEEEE)),
      ],
    );
  }
}