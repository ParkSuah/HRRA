
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'data.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

// FirebaseStorage storage = FirebaseStorage(
//     storageBucket: storagePath
// );

// Future<dynamic> uploadImage(File imageFile) async {
//   //Create a reference to the location you want to upload to in firebase
//   StorageReference reference = storage.ref().child("images").child(path.basename(imageFile.path));
//   //Upload the file to firebase
//   return reference.putFile(imageFile).onComplete;
// }
//
// Future<String> getImageURL(String filename) async {
//
//   return await storage.ref().child('images').child(filename).getDownloadURL();
// }

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
        assert(cu_position_dutystation != null)
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
        created = map['created']??null,
        modified = map['modified']??null
  ;

  Offer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  // String get imagePath => 'gs://final1009-da751.appspot.com/images/' + filename;//'$id-0.jpg';

}