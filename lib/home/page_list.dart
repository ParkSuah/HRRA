import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/components/components.dart';

// TODO Replace with object model.
const String listItemTitleText = "Job Offer";
const String listItemPreviewText =
      "You can display your job and find new person for your job position.";
const String listItemTitleText3 = "HR View";
const String listItemPreviewText3 =
    "Human Relocation View";
const String listItemTitleText5 = "Possible Matching";
const String listItemPreviewText5 =
    "AI will match the best position";
const String listItemTitleText2 = "Job Apply";
const String listItemPreviewText2 =
    "You can apply your interested job here.";
const String listItemTitleText4 = "Hiring Manager";
const String listItemPreviewText4 =
    "Hiring Manager View";

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  MenuBar(),
                  ListItem(
                      imageUrl:
                      "assets/images/paper_flower_overhead_bw_w1080.jpg",
                      title: listItemTitleText,
                      description: listItemPreviewText),
                  divider,
                  ListItem(
                      imageUrl:
                      "assets/images/iphone_cactus_tea_overhead_bw_w1080.jpg",
                      title: listItemTitleText2,
                      description: listItemPreviewText2),
                  divider,
                  ListItem(
                      imageUrl:
                      "assets/images/typewriter_overhead_bw_w1080.jpg",
                      title: listItemTitleText3,
                      description: listItemPreviewText3),
                  divider,
                  ListItem(
                      imageUrl:
                      "assets/images/coffee_paperclips_pencil_angled_bw_w1080.jpg",
                      title: listItemTitleText4,
                      description: listItemPreviewText4),
                  divider,
                  ListItem(
                      imageUrl:
                      "assets/images/joy_note_coffee_eyeglasses_overhead_bw_w1080.jpg",
                      title: listItemTitleText5,
                      description: listItemPreviewText5),
                  divider,
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}