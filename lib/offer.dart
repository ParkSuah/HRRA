
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'data.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class Offer {
  Offer({
    @required this.uuid,
    @required this.PHP,
    @required this.ID,
    @required this.firstname,
    @required this.lastname,
    @required this.gender,
    @required this.nationality,
    @required this.cu_position_title,
    @required this.cu_position_level,
    @required this.cu_position_dutystation,
    @required this.isSelected,
    this.created,
    this.modified,
  }) :
        assert(uuid != null),
        assert(PHP != null),
        assert(ID != null),
        assert(firstname != null),
        assert(lastname != null),
        assert(gender != null),
        assert(nationality != null),
        assert(cu_position_title != null),
        assert(cu_position_level != null),
        assert(cu_position_dutystation != null),
        assert(isSelected != null)
  //assert(created != null)
  //assert(modified != null)
      ;

  final String uuid;
  final String PHP;
  final String ID;
  final String firstname;
  final String lastname;
  final String gender;
  final String nationality;
  final String cu_position_title;
  final String cu_position_level;
  final String cu_position_dutystation;
  bool isSelected;
  final Timestamp created;
  final Timestamp modified;
  DocumentReference reference;

  Offer.fromMap(Map<String, dynamic> map, {this.reference})
      :
        assert(map['uuid'] != null),
        assert(map['PHP'] != null),
        assert(map['ID'] != null),
        assert(map['firstname'] != null),
        assert(map['lastname'] != null),
        assert(map['gender'] != null),
        assert(map['nationality'] != null),
        assert(map['cu_position_title'] != null),
        assert(map['cu_position_level'] != null),
        assert(map['cu_position_dutystation'] != null),
        assert(map['isSelected'] != null),
  //assert(map['created'] != null),
  //assert(map['modified'] != null),
        uuid = map['uuid'],
        PHP = map['PHP'],
        ID = map['ID'],
        firstname = map['firstname'],
        lastname = map['lastname'],
        gender = map['gender'],
        nationality = map['nationality'],
        cu_position_title = map['cu_position_title'],
        cu_position_level = map['cu_position_level'],
        cu_position_dutystation = map['cu_position_dutystation'],
        isSelected = map['isSelected'],
        created = map['created']??null,
        modified = map['modified']??null
  ;

  Offer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  // String get imagePath => 'gs://final1009-da751.appspot.com/images/' + filename;//'$id-0.jpg';

}

class Apply {
  Apply({
    @required this.uuid,
    @required this.title,
    @required this.level,
    @required this.post,
    @required this.division,
    @required this.branch,
    @required this.duty,
    this.created,
    this.modified,
  }) :
        assert(uuid != null),
        assert(title != null),
        assert(level != null),
        assert(post != null),
        assert(division != null),
        assert(branch != null),
        assert(duty != null)
  //assert(created != null)
  //assert(modified != null)
      ;

  final String uuid;
  final String title;
  final String level;
  final String post;
  final String division;
  final String branch;
  final String duty;
  final Timestamp created;
  final Timestamp modified;
  DocumentReference reference;

  Apply.fromMap(Map<String, dynamic> map, {this.reference})
      :
        assert(map['uuid'] != null),
        assert(map['title'] != null),
        assert(map['level'] != null),
        assert(map['post'] != null),
        assert(map['division'] != null),
        assert(map['branch'] != null),
        assert(map['duty'] != null),
  //assert(map['created'] != null),
  //assert(map['modified'] != null),
        uuid = map['uuid'],
        title = map['title'],
        level = map['level'],
        post = map['post'],
        division = map['division'],
        branch = map['branch'],
        duty = map['duty'],
        created = map['created']??null,
        modified = map['modified']??null
  ;

  Apply.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

// String get imagePath => 'gs://final1009-da751.appspot.com/images/' + filename;//'$id-0.jpg';

}

